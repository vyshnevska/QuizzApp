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
    flash[:notice] = "Please add question and answers for #{@quizz.description}. Mark correct answers."
  end

  def create
    #binding.pry
    @quizz = Quizz.create(params[:quizz])
    respond_to do |format|
      if @quizz.save
        flash[:notice] = "Thank you for creating this quizz"
        if @quizz.update_attribute(:status, "editable")
          flash[:notice] << "Editable mode."
        end
        format.html { redirect_to @quizz}
        format.js
      else
        flash[:notice] = "Please fix below errors."
        format.html { render action: "new" }
        #format.json { render json: @quizz.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update

    ids = []
    q_saved_ids = []
    a_saved_ids = []
    @quizz = Quizz.find(params[:id])
    @q= Question.where(:quizz_id => params[:id])
    @q.each do |q|
      q_saved_ids << q.id
      @a = Answer.where(:question_id => q.id)
      @a.each do |a|
        a_saved_ids << a.id
      end
    end

    ids = params[:correct_ids].keys.collect {|k| k.to_i}

    ids.each do |id|
      @ca = Answer.find_by_id(id)
      @ca.mark_as_correct
      if @ca.save
        flash[:notice] = 'Answer was successfully marked.' #bug here
      end
    end
    (a_saved_ids - ids).each do |e|
      @ia = Answer.find_by_id(e)
      @ia.mark_as_incorrect
      if @ia.save
        flash[:notice] = 'Answer was successfully unmarked.' #bug here
      end
    end

    respond_to do |format|
      if @quizz.update_attributes(params[:quizz])
        flash[:notice] << 'Quizz was successfully updated.'
        format.html { redirect_to @quizz } #, :notice << 'Quizz was successfully updated.'}
        #' Answer was successfully marked.' }
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
