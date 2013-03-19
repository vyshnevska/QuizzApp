class GameDetail < ActiveRecord::Base
  attr_accessible :game_id, :question_id, :answer_id
  belongs_to :game
  belongs_to :question
  belongs_to :answer

  validates :game_id, :presence => { :message => "game must be assigned" }
  validates :question_id, :presence => { :message => "question must be assigned" }
  validates :answer_id, :presence => { :message => "answer must be assigned" }
end
