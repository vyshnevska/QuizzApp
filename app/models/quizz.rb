class Quizz < ActiveRecord::Base
  include AASM
  attr_accessible :questions_attributes, :description

  has_many :questions, :dependent => :destroy
  has_many :games
  has_many :users, :through => :games

  accepts_nested_attributes_for :questions, :allow_destroy => :true

  validates :description, :presence => {:message => I18n.translate('missed_descr') }, :uniqueness => {:message => "Quizz name must be unique." }

  attr_protected :status
  aasm_column :status

  aasm_initial_state :draft
  aasm_state :draft
  aasm_state :completed

  aasm_event :set_to_completed do
    transitions :from => :draft, :to => :completed
  end

  scope :draft,      where( status: 'draft'     )
  scope :completed,  where( status: 'completed' )
end
