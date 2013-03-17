class Question < ActiveRecord::Base
  attr_accessible :answers_attributes, :title
  has_many :answers, :dependent => :destroy, :autosave => true
  belongs_to :quizz#, autosave: true
  accepts_nested_attributes_for :answers, :allow_destroy => :true

  validates :title, :presence => true
  #validates_presence_of :quizz
  #validates_associated :answers
  #validates_associated :quizz
end
