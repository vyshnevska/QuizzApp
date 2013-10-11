class Game < ActiveRecord::Base
  include AASM

  attr_accessible :user_id, :quizz_id#, :points

  belongs_to :user
  belongs_to :quizz
  has_many :game_details

  scope :passed_games, joins(:game_details).where("points IS NOT NULL").group("games.id")
  #scope :created_games, joins(:game_details).where("points IS NULL").group("games.id")
  scope :created_games, where("points IS NULL").group("id")
  
  attr_protected :state
  aasm_column :state

  aasm_initial_state :draft
  aasm_state :draft
  aasm_state :started
  aasm_state :finished


  aasm_event :process do
    transitions :from => :draft, :to => :started
  end

  aasm_event :finish do
    transitions :from => :started, :to => :finished
  end

  scope :draft,    where( state: 'draft'    )
  scope :started,  where( state: 'started'  )
  scope :finished, where( state: 'finished' )

  def get_points user_answer_id
    self.points += (game_details.joins(:answer).where("answers.id= ? AND answers.correct = ?", user_answer_id, true).count) *10
  end

  def is_passed? game
    # TODO
  end

  def total_score
    self.quizz.questions.count*10
  end

  def played_game
    quizz_id = self.quizz.id
    Game.where("quizz_id =?", quizz_id).count
  end
 
end
