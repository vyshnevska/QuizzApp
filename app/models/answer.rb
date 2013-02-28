class Answer < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :question
end
