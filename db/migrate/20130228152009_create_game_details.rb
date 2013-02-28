class CreateGameDetails < ActiveRecord::Migration
  def change
    create_table :game_details do |t|
      t.integer :game_id
      t.integer :question_id
      t.integer :answer_id
      t.timestamps
    end
  end
end
