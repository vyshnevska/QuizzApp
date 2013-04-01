class Answer < ActiveRecord::Base
  attr_accessible :content
  belongs_to :question
  validates :content, :presence => true
  
  def is_correct?
    correct
  end

  def mark_as_correct
    correct = true
  end

  def mark_as_incorrect
    correct = false
  end
end
