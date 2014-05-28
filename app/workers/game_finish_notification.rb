class GameFinishNotification
  @queue = :games_queue

  def self.perform(game_id)
    game = Game.find(game_id)
    if User.current_user.can_send_mail?
      UserMailer.finish_game(game.id).deliver if User.current_user.can_send_mail?
      game.update_attribute(:emailed, true)
    end
  end
end