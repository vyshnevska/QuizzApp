class Quizz < ActiveRecord::Base
  attr_accessible :questions_attributes, :description
  has_many :questions, :dependent => :destroy
  has_many :games
  has_many :users, :through => :games
  accepts_nested_attributes_for :questions, :allow_destroy => :true
  STATES = %w[draft complete]

  validates :description, :presence => {:message => "Blank quizz name is not allowed." }, :uniqueness => {:message => "Quizz name must be unique." }

  before_create :assign_state

  def is_draft?
    status == "draft" ? true : false
  end

  def is_complete?
    status == "complete" ? true : false
  end

  private
  	def assign_state
  		self.status = "draft"
  	end
end
