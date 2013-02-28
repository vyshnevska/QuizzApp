class Question < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :answers
  belongs_to :quizz
end
