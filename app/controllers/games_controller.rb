class GamesController < ApplicationController
  #before_filter :authenticate_user!
  skip_before_filter :authenticate_user!, :only => :welcome

  def welcome
    if current_user
      @count_games = current_user.games.count
      @c_p = 0
      @score = 0
      current_user.games.passed_games.each do |game|
        @c_p+= game.points
        @score += game.total_score
      end 
      # UserMailer.welcome_email(current_user).deliver
      # UserMailer.test_email.deliver
    end
  end

  def index
    if current_user.role == "admin"
      @games_new = Game.created_games
      @games_passed = Game.passed_games
    else
      @games_new = current_user.games.created_games
      @games_passed = current_user.games.passed_games
    end
  end

  def show
    @game = Game.find(params[:id])
    #details = GameDetail.where(:game_id => params[:id])
    #details = @game.game_details
    #@answers = []
    #if !details.blank?
    #  details.each do |d|
    #    @answers << d.answer_id
    #  end
    #end
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
    flash[:notice] = 'You are reviewing...'
    render :show, :game => @game , :answers => @answers
  end

  def new
    @game = Game.new
  end

  def edit
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.new(params[:game])
    if @game.save
      redirect_to @game, notice: 'Game was successfully created.'
    else
      render :new
    end
  end

  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(params[:game])
      redirect_to @game, notice: 'Game was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to games_url
  end

  def start
    @game = Game.find_by_id(params[:id])
    @quizz = @game.quizz
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
      flash[:error] = "Can't run the same game twice. This game was already finished!"
      @game.errors.add(:base, "Can't run the same game twice. Game #{@game.id} was already finished!")
    end
    if !@game.errors.any?
      @game.save
      redirect_to @game, notice: "You have finished this game successfully!"
    else
      redirect_to games_path
    end
  end

end
