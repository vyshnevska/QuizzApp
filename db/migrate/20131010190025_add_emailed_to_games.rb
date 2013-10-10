class AddEmailedToGames < ActiveRecord::Migration
  def change
    add_column :games, :emailed, :boolean
  end
end
