class QuizzsController < ApplicationController
  # GET /quizzs
  # GET /quizzs.json
  def index
    @quizzs = Quizz.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @quizzs }
    end
  end

  # GET /quizzs/1
  # GET /quizzs/1.json
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

  # POST /quizzs
  # POST /quizzs.json
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

  # PUT /quizzs/1
  # PUT /quizzs/1.json
  def update
    #binding.pry
    @quizz = Quizz.find(params[:id])
    #@questions = Question.where(:quizz_id => params[:id])
    #@answers = Answer.where(:question_id =>params[:question_id] )
    #@quizz.questions.answers.each do |a|
    #  @quizz.update_attributes(params[:quizz][:questions_attributes][:answers_attributes])
    #end
    #@quizz.questions.each do |q|
    #  q.answers.each do |a|
    #   a.update_attributes(params[:quizz][:questions_attributes][:answers_attributes])
    #  end
    #  q.update_attributes(params[:quizz][:questions_attributes])
    #end

    @quizz.update_attributes(params[:quizz])

    respond_to do |format|
      format.html { redirect_to @quizz, notice: 'Quizz was successfully updated.' }
      format.json { head :no_content }
    end
  end

  # DELETE /quizzs/1
  # DELETE /quizzs/1.json
  def destroy
    @quizz = Quizz.find(params[:id])
    @quizz.destroy

    respond_to do |format|
      format.html { redirect_to quizzs_path }
      format.json { head :no_content }
    end
  end
end
