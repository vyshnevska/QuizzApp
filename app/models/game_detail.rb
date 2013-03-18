class GameDetail < ActiveRecord::Base
  attr_accessible :game_id, :question_id, :answer_id
  belongs_to :game
  belongs_to :question
  belongs_to :answer

end
