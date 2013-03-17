class Answer < ActiveRecord::Base
  attr_accessible :content, :id
  belongs_to :question#, :autosave => true
  def is_correct?
    self.correct
  end
  def mark_as_correct
    self.correct = true
  end
  validates :content, :presence => true
  #validates_presence_of :question
  #validates_associated :question
end
