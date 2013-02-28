class CreateQuizzs < ActiveRecord::Migration
  def change
    create_table :quizzs do |t|
      t.string :description, :null => false, :default => ""
      t.string :status
      t.integer :created_by
      t.timestamps
    end
  end
end
