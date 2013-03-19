class AddCorrectToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :correct, :boolean, :null => false, :default => false
  end
end
