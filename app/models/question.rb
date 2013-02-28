class Question < ActiveRecord::Base
  attr_accessible :answers_attributes, :title
  has_many :answers
  belongs_to :quizz
  accepts_nested_attributes_for :answers, :allow_destroy => :true
end
