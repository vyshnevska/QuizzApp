class Question < ActiveRecord::Base
  attr_accessible :answers_attributes, :title, :quizz_id

  has_many :answers, :dependent => :destroy
  belongs_to :quizz

  accepts_nested_attributes_for :answers, :allow_destroy => :true

  validates :title, :presence => {:message => I18n.translate('validation.title')}

  def answers_by_qst
    Answer.where("question_id = ?", self.id)
  end

end
