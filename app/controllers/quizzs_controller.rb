class QuizzsController < ApplicationController
  before_filter :set_quizz, :only => [:complete, :show, :edit, :update, :destroy]

  def index
    @quizzes = Quizz.by_state
    flash[:notice] = I18n.translate('index.no_active') unless Quizz.exists?
  end

  def complete
    if @quizz.set_to_completed!
      flash[:notice] = I18n.translate('complete.notification', :quizz_id => @quizz.id)
      redirect_to  quizzs_path
    end
  end

  def show
    respond_to do |format|
      format.html {}
      format.csv {
        send_data(
          @quizz.generate_csv(["id", "description", "status"]),
          :disposition => "attachment; filename=\"quizz_#{@quizz.id}\".csv"
        )
      }
      format.xls do
        response.headers['Content-Disposition'] = "attachment; filename=\"quizz_#{@quizz.id}\".xls"
        render "show.xls.erb"
      end
    end
  end

  def new
    @quizz = Quizz.new
    question = @quizz.questions.build
    question.answers.build
  end

  def edit
    if @quizz.completed?
      flash[:error] =  I18n.translate('edit.cant_edit')
    else
      flash[:notice] = I18n.translate('edit.mark_answers', :quizz_id => @quizz.id, :description => @quizz.description)
    end
  end

  def create
    @quizz = Quizz.new(params[:quizz])
    build_quizz_parameters(@quizz, params[:questions])
    if @quizz.save
      flash[:notice] = I18n.translate('created', :quizz_id => @quizz.id)
      redirect_to quizzs_path
    else
      flash[:error] = @quizz.errors.values.join("\n")
      render :new
    end
  end

  def update
    @valid = @quizz.update_attributes(:description => params[:quizz][:description])
    if params[:quizz][:questions]
      params[:quizz][:questions].each do |question_id, data|
        q =  @quizz.questions.where(:id => question_id).first
        q.title = data[:title]
        update_answers(data, q)
        @valid = q.save
      end
    end
    flash[:notice] = I18n.translate('updated', :quizz_id => @quizz.id) if @valid
    redirect_to quizzs_path
  end

  def destroy
    @quizz.destroy
    flash[:notice] = I18n.translate('deleted', :quizz_id => @quizz.id)
    redirect_to quizzs_path
  end

  private
    def set_quizz
      @quizz = Quizz.find(params[:id])
    end

    def build_quizz_parameters(quizz, questions)
      questions.each do |q|
        quizz.questions.build(:title => q[:title])
        q[:answers].each do |a|
          quizz.questions.last.answers.build(:content => a, :correct => false)
        end
      end
    end

    def update_answers(data, question)
      if data[:answers_attributes]
        data[:answers_attributes].each do |answer_id, data|
          a =  question.answers.where(:id => answer_id).first
          data[:correct] = "false" unless data.include?("correct")
          a.update_attributes(data)
        end
      end
    end
end
