class AddIndexes < ActiveRecord::Migration
  def up
    add_index :answers, :question_id

    add_index :friendships, :user_id
    add_index :friendships, :friend_id

    add_index :game_details, :game_id
    add_index :game_details, :question_id
    add_index :game_details, :answer_id

    add_index :games, :user_id
    add_index :games, :quizz_id

    add_index :questions, :quizz_id
  end

  def down
    remove_index :answers, :question_id

    remove_index :friendships, :user_id
    remove_index :friendships, :friend_id

    remove_index :game_details, :game_id
    remove_index :game_details, :question_id
    remove_index :game_details, :answer_id

    remove_index :games, :user_id
    remove_index :games, :quizz_id

    remove_index :questions, :quizz_id
  end
end
