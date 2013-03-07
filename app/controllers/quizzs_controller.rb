class QuizzsController < ApplicationController
  before_filter :authenticate_user!

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

  # GET /quizzs/new
  # GET /quizzs/new.json
  def new
    @quizz = Quizz.new
    2.times do
      question = @quizz.questions.build
      3.times {question.answers.build}

    end

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @quizz }
    end
  end

  # GET /quizzs/1/edit
  def edit
    @quizz = Quizz.find(params[:id])
  end

  # POST /quizzs
  # POST /quizzs.json
  def create
    @quizz = Quizz.create!(params[:quizz])
    flash[:notice] = "Thank you for creating this quizz"
    respond_to do |format|
      format.html { redirect_to @quizz}
      format.js
    end
    #respond_to do |format|
    #  if @quizz.save
    #    format.html { redirect_to @quizz, notice: 'Quizz was successfully created.' }
    #    format.json { render json: @quizz, status: :created, location: @quizz }
    #  else
    #    format.html { render action: "new" }
    #    format.json { render json: @quizz.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PUT /quizzs/1
  # PUT /quizzs/1.json
  def update
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

  # DELETE /quizzs/1
  # DELETE /quizzs/1.json
  def destroy
    @quizz = Quizz.find(params[:id])
    @quizz.destroy

    respond_to do |format|
      format.html { redirect_to quizzs_url }
      format.json { head :no_content }
    end
  end
end
