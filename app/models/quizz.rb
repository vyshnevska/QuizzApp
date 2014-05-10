class Quizz < ActiveRecord::Base
  include AASM
  attr_accessible :questions_attributes, :description

  has_many :questions, :dependent => :destroy
  has_many :games
  has_many :users, :through => :games

  accepts_nested_attributes_for :questions, :allow_destroy => :true

  validates :description, :presence => { :message => I18n.translate('validation.description') },
            :uniqueness => { :message => I18n.translate('validation.unique_description') }

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
  scope :alphabetically, order("description ASC")
  scope :by_state, order("status, updated_at ASC")

  def mark_answers ans_ids
    self.questions.each do |question|
      question.answers_by_qst.each do |answer|
        if ans_ids.include?(answer.id)
          answer.mark_as_correct
        else
          answer.mark_as_incorrect
        end
      end
    end
  end

end
