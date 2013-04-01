class Game < ActiveRecord::Base
  attr_accessible :user_id, :quizz_id, :points
  belongs_to :user
  belongs_to :quizz
  has_many :game_details

  scope :passed_games, joins(:game_details).where("points IS NOT NULL").group("games.id")
  scope :created_games, joins(:game_details).where("points IS NULL").group("games.id")
end
