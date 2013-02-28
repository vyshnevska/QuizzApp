class Quizz < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :questions
  has_many :games
  has_many :users, :through => :games

end
