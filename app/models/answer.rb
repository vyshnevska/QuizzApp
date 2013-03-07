class Answer < ActiveRecord::Base
  attr_accessible :content
  belongs_to :question

  validates :content, :presence => true
  validates_associated :question
end
