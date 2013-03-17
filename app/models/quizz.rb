class Quizz < ActiveRecord::Base
  attr_accessible :questions_attributes, :description
  has_many :questions#, :dependent => :destroy, :autosave => true
  has_many :games
  has_many :users, :through => :games
  accepts_nested_attributes_for :questions, :allow_destroy => :true

  validates :description, :presence => true#, :uniqueness => true
  #validates_associated :questions
  #validates_associated :games
  #validates_associated :users
end
