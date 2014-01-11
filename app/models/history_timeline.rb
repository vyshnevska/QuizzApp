class HistoryTimeline < ActiveRecord::Base
  attr_accessible :title, :description

  has_many :century_timelines
end
