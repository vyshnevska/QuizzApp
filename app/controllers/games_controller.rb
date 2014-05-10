class GamesController < ApplicationController
  skip_before_filter :authenticate_user!, :only => :home

  def home
  end

  def welcome
    if current_user
      @count_games = current_user.assigned_games
      @count_passed_games = current_user.passed_games.count
      @user_score = current_user.total_score
      @max_score = current_user.maximum_score

      # UserMailer.welcome_email(current_user).deliver
      # flash[:notice] = I18n.translate('mail.sent_notification', :current_user => current_user.name)

      current_user.inverse_friends.each do |fs|
        @inverse_friends  = fs.name
      end
      @users = User.without_user(current_user)
      # UserMailer.test_email.deliver
    end
  end

  def index
    @quizzes = Quizz.completed.alphabetically.page(params[:page]).per(5)
    if current_user.role == "admin"
      @new_games = current_user.games.created_games.page(params[:page]).per(5)
      @games_passed = Game.passed_games.page(params[:page]).per(5)
      flash[:notice] = I18n.translate('index.new_game') unless Game.exists?
    else
      @new_games = current_user.games.created_games.page(params[:page]).per(5)
      @games_passed = current_user.games.passed_games.page(params[:page]).per(5)
      flash[:notice] = I18n.translate('index.new_user_game', :current_user => current_user.name) unless current_user.games.exists?
    end
  end

  def paginate_available
    @quizzes = Quizz.completed.alphabetically.page(params[:page]).per(5)

    respond_to do |format|
      format.js
    end
  end

  def paginate_created
    @new_games = current_user.games.created_games.page(params[:page]).per(5)

    respond_to do |format|
      format.js
    end
  end

  def paginate_passed
    @games_passed = current_user.role == "admin" ? Game.passed_games.page(params[:page]).per(5) : current_user.games.passed_games.page(params[:page]).per(5)

    respond_to do |format|
      format.js
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
      @other_users = @game.other_players
    end

    flash[:notice] = I18n.translate('review')
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
      #Should show in another place
      # flash[:error] = I18n.translate('finish.same_game', :game_id => @game.id)
      @game.errors.add(:base, I18n.translate('finish.same_game', :game_id => @game.id))
    end
    if !@game.errors.any?
      @game.save
      # Resque.enqueue(GameFinishNotification, @game.id)
      @game.set_to_finished!
      redirect_to @game, :locals=> {:state => "finished"}, notice: I18n.translate('finish.successfully')
    else
      flash[:error] = @game.errors.values.join("\n")
      redirect_to games_url
    end
  end

end
