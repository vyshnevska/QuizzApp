class Quizz < ActiveRecord::Base
  attr_accessible :questions_attributes, :description
  has_many :questions
  has_many :games
  has_many :users, :through => :games
  accepts_nested_attributes_for :questions, :allow_destroy => :true

end
