require "pry"

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
  end

  def create
    @quizz = Quizz.create!(params[:quizz])
    flash[:notice] = "Thank you for creating this quizz"
    respond_to do |format|
      format.html { redirect_to @quizz}
      format.js
    end
  end

  def update
    #binding.pry
    @quizz = Quizz.find(params[:id])

    respond_to do |format|
      if @quizz.update_attributes(params[:quizz])
        format.html { redirect_to @quizz, notice: 'Quizz was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @quizz.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @quizz = Quizz.find(params[:id])
    @quizz.destroy

    respond_to do |format|
      format.html { redirect_to quizzs_url }
      format.json { head :no_content }
    end
  end
end
