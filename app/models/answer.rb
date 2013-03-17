class Answer < ActiveRecord::Base
  attr_accessible :content
  belongs_to :question#, :autosave => true

  validates :content, :presence => true
  #validates_presence_of :question
  #validates_associated :question
end
