class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :user_id
      t.integer :quizz_id
      t.integer :points
      t.timestamps
    end
  end
end
