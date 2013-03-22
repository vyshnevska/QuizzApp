class GamesController < ApplicationController
  def index
    @g = Game.all
    @user = current_user
    @games_new = []
    @games_passed = []
    #@q_new = []
    #@q_passed = []

    if @user
      @g.each do |g|
        @d = GameDetail.where(:game_id => g.id)
        #binding.pry
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
        #binding.pry
        @games_new << g2
      end
      #@q_new = Quizz.where(:id => @g.quizz_id)
    end


    #@games_new = Game.where('points IS NULL and ')
    #Game.where('user_id != ?', @user.id)
    #@games_passed = Game.where('user_id = ?', @user.id)

    #@games_passed = Game.where('points IS NOT NULL')
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
    @quizz = Quizz.where(:id => @game.quizz_id).first
  end

  def finish

    @game = Game.find(params[:id])
    details = params[:answers]
    details.each do |q, a|
      @g_d = GameDetail.new(:game_id => params[:id], :question_id => q, :answer_id => a)
      @g_d.save
    end
    det = GameDetail.where(:game_id => params[:id])
    @game.points = 0
    det.each do |d|
      @ans = Answer.where(:id => d.answer_id)

      if @ans.first.is_correct?
        @game.points += 10
      end
    end

    @game.save
    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: "You have finished this game successfully!" }
        format.json { head :no_content }
      end
    end
  end

end
