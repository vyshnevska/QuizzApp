require "pry"

class QuizzsController < ApplicationController
  def index
    flash[:notice] = "There is no active quizz now. Please create new." unless Quizz.exists?
    @quizzes = Quizz.by_state
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
    flash[:notice] = "Please mark correct answers for Quizz # #{@quizz.id} #{@quizz.description}."

    unless @quizz.draft?
      flash[:notice] << "You can't edit this quizz."
    end
    
  end

  def create
    @errors = []
    @quizz = Quizz.new(params[:quizz])
    if @quizz.save
      params["questions"].each do |question|
        new_quest = @quizz.questions.build(:title => question["title"])
        question["answers"].each do |answer|
          new_quest.answers.build(:content => answer)
        end
        if !new_quest.save
          # TODO: refactor this
          flash[:error] = new_quest.errors.values.join("\n")
          @errors = new_quest.errors.values.join("\n")
        end
      end
    else
      @errors = @quizz.errors.values.join("\n")
    end

    if @quizz.errors.empty? && @errors.empty?
      flash[:notice] = "Quizz # #{@quizz.id} was created."
      redirect_to quizzs_path
    else
      flash[:error] = @errors
      render :new
    end
  end

  def update
    @quizz = Quizz.find(params[:id])
    if params[:correct_ids]
      @quizz.mark_answers params[:correct_ids].values.collect {|v| v.to_i}
    else
      flash[:notice] = 'No answer is marked.'
    end

    if @quizz.update_attributes(params[:quizz])
      flash[:notice] = "Quizz# #{@quizz.id} is updated."
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
