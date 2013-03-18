class Answer < ActiveRecord::Base
  attr_accessible :content
  belongs_to :question

  validates :content, :presence => true
  #validates_associated :question
  def is_correct?
    self.correct
  end
  def mark_as_correct
    self.correct = true
  end
  def mark_as_incorrect
    self.correct = false
  end
end
