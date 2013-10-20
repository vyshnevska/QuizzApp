require "pry"

class QuizzsController < ApplicationController
  def index
    flash[:notice] = "There is no active quizz now. Please create new." unless Quizz.exists?
    @quizzes = Quizz.all
  end

  def complete
    @quizz = Quizz.find(params[:id])
    if @quizz.set_to_completed!
      flash[:notice] = "Quizz# #{@quizz.id} is completed!"
      redirect_to  quizzs_path
    end
  end

   def new
    flash[:notice]  = nil
     @quizz = Quizz.new
     question = @quizz.questions.build
     question.answers.build
     #render :edit
   end

  def edit
    @quizz = Quizz.find(params[:id])
    flash[:notice] = "Please add question and answers for #{@quizz.description}. Mark correct answers."
    if @quizz.draft?
      flash[:notice] << "This quizz is in editable mode."
    else
      flash[:notice] << "You can't edit this quizz."
     end
    
  end

  def create
    @quizz = Quizz.create(params[:quizz])
    
    if @quizz.errors.empty?
      flash[:notice] = "Thank you for creating this quizz"
      redirect_to quizzs_path
    else
      flash[:error] = @quizz.errors.values.join("\n")
      render :new 
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
          flash[:notice] = 'Answer is  marked. ' #bug here
        end
      end
      (a_saved_ids - ids).each do |e|
        @ia = Answer.find_by_id(e)
        @ia.mark_as_incorrect
        if @ia.save
          flash[:notice] = 'Answer is unmarked. ' #bug here
        end
      end
    else
      flash[:notice] = 'No answer is marked. '
    end
    if @quizz.update_attributes(params[:quizz])
        flash[:notice] << "Quizz# #{@quizz.id} is updated."
        redirect_to quizzs_path
    else
      render :edit
    end
  end

  def destroy
    @quizz = Quizz.find(params[:id])
    @quizz.destroy
    flash[:notice] = "Quizz# #{@quizz.id} is deleted."
    redirect_to quizzs_path
  end
end
