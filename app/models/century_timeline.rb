class CenturyTimeline < ActiveRecord::Base
  attr_accessible :title, :description, :person, :period, :impact_type

  belongs_to :history_timeline
end
