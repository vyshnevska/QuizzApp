class Game < ActiveRecord::Base
  attr_accessible :user_id, :quizz_id, :points
  belongs_to :user
  belongs_to :quizz
  has_many :game_details
end
