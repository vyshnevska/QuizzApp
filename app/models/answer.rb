class Answer < ActiveRecord::Base
  # attr_accessible :content, :correct
  belongs_to :question
  validates :content, :presence => {:message => I18n.translate('validation.content')}

  def mark_as_correct
    self.correct = true
  end

  def mark_as_incorrect
    self.correct = false
  end
end
