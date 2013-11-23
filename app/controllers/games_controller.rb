class GamesController < ApplicationController
  #before_filter :authenticate_user!
  skip_before_filter :authenticate_user!, :only => :welcome

  def welcome
    if current_user
      @count_games = current_user.assigned_games
      @count_passed_games = current_user.passed_games.count
      @user_score = current_user.total_score
      @max_score = current_user.maximum_score

      # UserMailer.welcome_email(current_user).deliver
      # flash[:notice] = I18n.translate('games.send_mail_msg', :current_user => current_user.name)

      current_user.inverse_friends.each do |fs|
        @inverse_friends  = fs.name
      end
      @users = User.without_user(current_user)
      # UserMailer.test_email.deliver
    else
      @users = User.all
    end
  end

  def index
    @quizzes = Quizz.completed.alphabetically.page(params[:page]).per(5)
    if current_user.role == "admin"
      # @games_new = Game.created_games
      @games_new = current_user.games.created_games.page(params[:page]).per(5)
      @games_passed = Game.passed_games.page(params[:page]).per(5)
      flash[:notice] = I18n.translate('games.create_new_game_msg') unless Game.exists?
    else
      @games_new = current_user.games.created_games.page(params[:page]).per(5)
      @games_passed = current_user.games.passed_games.page(params[:page]).per(5)
      flash[:notice] = I18n.translate('games.user_create_new_game_msg', :current_user => current_user.name)  unless current_user.games.exists?
    end
  end

  def show
    @game = Game.find(params[:id])
    if @game.finished?
      quizz_id = @game.try(:quizz).try(:id)
      @scores = @game.other_games_scores @game.id, quizz_id if quizz_id

      #Statistic info
      @total_quizz_points =  @game.total_score
      @user_result = @game.game_score_percent
    end
  end

  def review
    @game = Game.find(params[:id])
    details = @game.game_details
    @answers = []
    if !details.blank?
      details.each do |d|
        @answers << d.answer_id
      end
    end
    if @game.finished?
      quizz_id = @game.try(:quizz).try(:id)
      @scores = @game.other_games_scores @game.id, quizz_id if quizz_id

      #Statistic info
      @total_quizz_points =  @game.total_score
      @user_result = @game.game_score_percent
    end

    flash[:notice] = I18n.translate('games.review_msg')
    render :show, :game => @game , :answers => @answers
  end

  def new
    @game = Game.new
    @game.quizz_id = params[:quizz_id]
    @game.user_id = current_user.id
    if @game.save
      start @game.id
    else
      render :new
    end
  end

  def edit
    redirect_to games_path
    # if current_user.role == "admin"
    #   @game = Game.find(params[:id])
    # else
    #   redirect_to games_path
    # end
  end

  def update
    redirect_to games_path
    # @game = Game.find(params[:id])
    # if @game.update_attributes(params[:game])
    #   redirect_to @game, notice: I18n.translate('games.successful_update_msg')
    # else
    #   render :edit
    # end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to games_path
  end

  def start game_id
    @game = Game.find_by_id(game_id)
    @quizz = @game.quizz
    # Resque.enqueue(GameStartNotification, @game.id)
    @game.set_to_started!
    render :start
  end

  def finish
    @game = Game.find(params[:id])
    if @game.game_details.blank?
      @answers = params[:answers]
      @game.points = 0
      @answers.each do |q_id, a_id|
        @game.game_details.create(:question_id => q_id, :answer_id => a_id)
        @game.get_points a_id
      end
    else
      flash[:error] = I18n.translate('games.run_same_game_error')
      @game.errors.add(:base, "Can't run the same game twice. Game #{@game.id} was already finished!")
    end
    if !@game.errors.any?
      @game.save
      # Resque.enqueue(GameFinishNotification, @game.id)
      @game.set_to_finished!
      redirect_to @game, :locals=> {:state => "finished"}, notice: I18n.translate('games.successful_finish_msg')
    else
      redirect_to games_url
    end
  end

end
