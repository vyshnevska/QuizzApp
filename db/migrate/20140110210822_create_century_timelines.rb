class CreateCenturyTimelines < ActiveRecord::Migration
  def change
    create_table :century_timelines do |t|
      t.string :title
      t.string :description
      t.string :person
      t.datetime :period
      t.string :impact_type
      t.integer :history_timeline_id
      t.timestamps
    end
  end
end
