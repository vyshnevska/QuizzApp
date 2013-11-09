class AddMaxScoreToGames < ActiveRecord::Migration
  def change
    add_column :games, :max_score, :integer
  end
end
