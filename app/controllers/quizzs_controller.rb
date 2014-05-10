class QuizzsController < ApplicationController
  def index
    @quizzes = Quizz.by_state
    flash[:notice] = I18n.translate('index.no_active') unless Quizz.exists?
  end

  def complete
    @quizz = Quizz.find(params[:id])
    if @quizz.set_to_completed!
      flash[:notice] = I18n.translate('complete.notification', :quizz_id => @quizz.id)
      redirect_to  quizzs_path
    end
  end

  def new
    @quizz = Quizz.new
    question = @quizz.questions.build
    question.answers.build
  end

  def edit
    @quizz = Quizz.find(params[:id])
    if @quizz.completed?
      flash[:error] =  I18n.translate('edit.cant_edit')
    else 
      flash[:notice] = I18n.translate('edit.mark_answers', :quizz_id => @quizz.id, :description => @quizz.description) 
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
      flash[:notice] = I18n.translate('created', :quizz_id => @quizz.id)
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
      flash[:notice] = I18n.translate('edit.no_marked')
    end

    if @quizz.update_attributes(params[:quizz])
      flash[:notice] = I18n.translate('updated', :quizz_id => @quizz.id)
      redirect_to quizzs_path
    else
      render :edit
    end
  end

  def destroy
    @quizz = Quizz.find(params[:id])
    @quizz.destroy
    flash[:notice] = I18n.translate('deleted', :quizz_id => @quizz.id)
    redirect_to quizzs_path
  end
end
