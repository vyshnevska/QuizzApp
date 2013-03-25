class GamesController < ApplicationController
  #before_filter :authenticate_user!
  skip_before_filter :authenticate_user!, :only => :welcome

  def welcome
    #do nothing
  end
  def index
    #binding.pry
    @g = Game.all
    @user = current_user
    @games_new = []
    @games_passed = []
    if @user
      @g.each do |g|
        @d = GameDetail.where(:game_id => g.id)
        if @d.empty?
          @games_new << g #Game.where('points IS NULL')
          #@q_new = Quizz.where(:id => g.quizz_id)
        else
          @games_passed << g
          #@q_passed = Quizz.where(:id => g.quizz_id)
        end
      end
    else
      @g.each do |g2|
         @games_new << g2
      end
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  def show
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game }
    end
  end

  def new
    @game = Game.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.new(params[:game])

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end

  def start
    @game = Game.find_by_id(params[:id])
    @quizz = @game.quizz
  end

  def finish
    @game = Game.find(params[:id])
    if GameDetail.where(:game_id => @game.id).blank?
      @answers = params[:answers]
      @game.points = 0
      @answers.each do |q_id, a_id|
        @game.game_details.create(:question_id => q_id, :answer_id => a_id)
        if Answer.find_by_id(a_id).is_correct?
          @game.points += 10
        end
      end
    else
      flash[:error] = "Can't run the same game twice. This game was already finished!"
      @game.errors.add(:base, "Can't run the same game twice. Game #{@game.id} was already finished!")
    end
    #binding.pry
    respond_to do |format|
      if !@game.errors.any?
        @game.save
        format.html { redirect_to @game, notice: "You have finished this game successfully!" }
        format.json { head :no_content }

      else
        format.html {redirect_to games_path }

      end
    end
  end

end
