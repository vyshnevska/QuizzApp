class AddCorrectToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :correct, :boolean, :default => false, :null => false
  end
end
