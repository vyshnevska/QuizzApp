class GameDetail < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :game
  belongs_to :question
  belongs_to :answer

end
