class Question < ActiveRecord::Base
  attr_accessible :answers_attributes, :title
  has_many :answers#,:dependent => :destroy
  belongs_to :quizz
  accepts_nested_attributes_for :answers, :allow_destroy => :true

  validates :title, :presence => true
  validates_associated :answers
  validates_associated :quizz
end
