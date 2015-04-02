class Answer < ActiveRecord::Base
  # attr_accessible :content, :correct
  belongs_to :question
  validates :content, :presence => {:message => I18n.translate('validation.content')}

  def is_correct?
    self.correct
  end

  def mark_as_correct
    self.correct = true
    save!
  end

  def mark_as_incorrect
    self.correct = false
    save!
  end
end
