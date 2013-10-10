class GameFinishNotification
  @queue = :games_queue

  def self.perform(game_id)
  	game = Game.find(game_id)
  	UserMailer.finish_game(game.id).deliver
  	game.update_attribute(:emailed, true)
  end
end