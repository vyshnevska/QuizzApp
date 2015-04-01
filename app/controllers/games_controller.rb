class GamesController < ApplicationController
  skip_before_filter :authenticate_user!, :only => :home

  before_filter :set_game, :only => [:show, :review, :start, :destroy, :finish]

  def home
    @updates_table = {
      :quizzes  => ['Export in CSV/XLS formats', 'View for individual quizz'],
      :account  => ['On/Off mail notifications'],
      :layout   => ['New UI for Quizzes', 'New UI for App Menu']
    }
  end

  def welcome
    if current_user.can_send_mail? && UserMailer.welcome_email(current_user).deliver
      flash[:notice] = I18n.translate('mail.sent_notification', :current_user => current_user.name)
    else
      flash[:notice] = I18n.translate('mail.no_notification', :current_user => current_user.name)
    end

    @users = User.without_user(current_user)
  end

  def index
    @quizzes = Quizz.completed.alphabetically.page(params[:page]).per(5)
    @new_games = current_user.games.with_quizz.page(params[:page]).per(5)
    if current_user.role == "admin"
      @games_passed = Game.passed_games.page(params[:page]).per(5)
      flash[:notice] = I18n.translate('index.new_game') if @games_passed.empty?
    else
      @games_passed = current_user.games.passed.page(params[:page]).per(5)
      flash[:notice] = I18n.translate('index.new_user_game', :current_user => current_user.name) unless current_user.games.exists?
    end
  end

  def paginate_available
    @quizzes = Quizz.completed.alphabetically.page(params[:page]).per(5)
  end

  def paginate_created
    @new_games = current_user.games.created_games.page(params[:page]).per(5)
  end

  def paginate_passed
    @games_passed = current_user.role == "admin" ? Game.passed_games.page(params[:page]).per(5) : current_user.games.passed.page(params[:page]).per(5)
  end

  def show
    if @game.finished?
      # quizz_id = @game.try(:quizz).try(:id)
      @scores = @game.other_games_scores# if quizz_id

      #Statistic info
      @user_result = @game.game_score_percent
    end
  end

  def review
    @answers = @game.game_details.map{|d| d.answer_id}
    if @game.finished?
      @scores = @game.other_games_scores

      #Statistic info
      @user_result = @game.game_score_percent
      @other_users = @game.other_players
    end

    flash[:notice] = I18n.translate('review')
  end

  def create
    @game = Game.create(:quizz_id =>  params[:quizz_id], :user_id => current_user.id) if params[:quizz_id]
    redirect_to start_game_path(@game)
  end

  def start
    # Resque.enqueue(GameStartNotification, @game.id)
    @game.set_to_started!
  end

  def edit
    redirect_to games_path
  end

  def update
    redirect_to games_path
  end

  def destroy
    @game.destroy
    redirect_to games_path
  end

  def finish
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
      Resque.enqueue(GameFinishNotification, @game.id)
      @game.set_to_finished!
      redirect_to @game, :locals=> {:state => "finished"}, notice: I18n.translate('finish.successfully')
    else
      flash[:error] = @game.errors.values.join("\n")
      redirect_to games_url
    end
  end

  private
    def set_game
      @game = Game.find(params[:id])
    end
end
