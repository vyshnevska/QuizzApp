class CreateHistoryTimelines < ActiveRecord::Migration
  def change
    create_table :history_timelines do |t|
      t.string :title
      t.string :description
      t.timestamps
    end
  end
end
