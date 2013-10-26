class Question < ActiveRecord::Base

  attr_accessible :answers_attributes, :title

  has_many :answers, :dependent => :destroy
  belongs_to :quizz

  accepts_nested_attributes_for :answers, :allow_destroy => :true

  validates :title, :presence => {:message => "Question title can't be blank."}

end
