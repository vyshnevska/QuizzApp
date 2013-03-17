class QuizzsController < ApplicationController
  def index
    @quizzs = Quizz.all
   respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @quizzs }
    end
  end

  def show
    @quizz = Quizz.find(params[:id])
   respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @quizz }
    end
  end

  def new
    @quizz = Quizz.new
    question = @quizz.questions.build
    question.answers.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @quizz }
    end
  end

  def edit
    @quizz = Quizz.find(params[:id])
    question = @quizz.questions.build
    question.answers.build
  end

  def create
    #binding.pry
    @quizz = Quizz.create!(params[:quizz])
    if @quizz.save
      flash[:notice] = "Thank you for creating this quizz"
    else
      render action: "new"
    end
    respond_to do |format|
      format.html { redirect_to @quizz}
      format.js
    end
  end

  def update
    #binding.pry
    @quizz = Quizz.find(params[:id])
    @quizz.update_attributes(params[:quizz])
    respond_to do |format|
      format.html { redirect_to @quizz, notice: 'Quizz was successfully updated.' }
      format.json { head :no_content }
    end
  end

  def destroy
    @quizz = Quizz.find(params[:id])
    @quizz.destroy

    respond_to do |format|
      format.html { redirect_to quizzs_path }
      format.json { head :no_content }
    end
  end
end
