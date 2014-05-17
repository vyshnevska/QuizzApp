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

  def best_user_score
    (@user_score != 0) && (@user_score == @max_score)
  end
end
