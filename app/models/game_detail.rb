class GameDetail < ActiveRecord::Base
  attr_accessible :game_id, :question_id, :answer_id
  belongs_to :game
  belongs_to :question
  belongs_to :answer

  validates :game_id,     :presence => { :message => I18n.translate('validation.game_presence') }
  validates :question_id, :presence => { :message => I18n.translate('validation.question_presence') }
  validates :answer_id,   :presence => { :message => I18n.translate('validation.answer_presence') }
end
