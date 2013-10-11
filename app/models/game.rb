class Game < ActiveRecord::Base
  attr_accessible :user_id, :quizz_id#, :points
  belongs_to :user
  belongs_to :quizz
  has_many :game_details

  scope :passed_games, joins(:game_details).where("points IS NOT NULL").group("games.id")
  #scope :created_games, joins(:game_details).where("points IS NULL").group("games.id")
  scope :created_games, where("points IS NULL").group("id")

  def get_points user_answer_id
    self.points += (game_details.joins(:answer).where("answers.id= ? AND answers.correct = ?", user_answer_id, true).count) *10
  end

  def is_passed? game
    # TODO
  end

  def total_score
    self.quizz.questions.count*10
  end

  # def total
  #   self.quizz.questions.count*10
  # end
 
end
