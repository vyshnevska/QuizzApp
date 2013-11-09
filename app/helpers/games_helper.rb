module GamesHelper
  def hamster_draft_games
    Game.draft.count
  end

  def hamster_started_games
    Game.started.count
  end

  def hamster_finished_games
    Game.finished.count
  end

end
