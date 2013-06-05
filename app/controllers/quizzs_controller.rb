require "pry"

class QuizzsController < ApplicationController
  def index
    @quizzs = Quizz.all
  end

  def show
    @quizz = Quizz.find(params[:id])
  end

 def new
   @quizz = Quizz.new
   question = @quizz.questions.build
   question.answers.build
   #render :edit
 end

  def edit
    @quizz = Quizz.find(params[:id])
    flash[:notice] = "Please add question and answers for #{@quizz.description}. Mark correct answers."
    if @quizz.is_draft?
      flash[:notice] << "This quizz is in editable mode."
    else
      flash[:notice] << "You can't edit this quizz."
     end
    
  end

  def create
    @quizz = Quizz.create(params[:quizz])
    if @quizz.save
      flash[:notice] = "Thank you for creating this quizz. "
      redirect_to @quizz
    else
      render :new
      flash[:error] = "Please fix below errors."
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
    if !params[:correct_ids].nil?
      ids = params[:correct_ids].keys.collect {|k| k.to_i}
      ids.each do |id|
        @ca = Answer.find_by_id(id)
        @ca.mark_as_correct
        if @ca.save
          flash[:notice] = 'Answer was successfully marked. ' #bug here
        end
      end
      (a_saved_ids - ids).each do |e|
        @ia = Answer.find_by_id(e)
        @ia.mark_as_incorrect
        if @ia.save
          flash[:notice] = 'Answer was successfully unmarked. ' #bug here
        end
      end
    else
      flash[:notice] = 'No answer was marked. '
    end
    if @quizz.update_attributes(params[:quizz])
        flash[:notice] << 'Quizz was successfully updated.'
        redirect_to @quizz
    else
      render :edit
    end
  end

  def destroy
    @quizz = Quizz.find(params[:id])
    @quizz.destroy
    redirect_to quizzs_url
  end
end
