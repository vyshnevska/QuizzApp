class Game < ActiveRecord::Base
  include AASM

  attr_accessible :user_id, :quizz_id

  belongs_to :user
  belongs_to :quizz
  has_many :game_details

  delegate :description, :to => :quizz, :prefix => true
  delegate :name,        :to => :user, :prefix => true

  scope :passed_games, joins(:game_details).where("points IS NOT NULL").group("games.id").order("games.created_at ASC")
  scope :created_games, where("points IS NULL").group("id").order("games.created_at ASC")
  scope :with_quizz, -> { joins(:quizz) }
  scope :without_points, -> { where('points IS NULL') }
  scope :passed, -> { where('points IS NOT NULL') }


  attr_protected :state
  aasm_column :state
  aasm_initial_state :draft
  aasm_state :draft
  aasm_state :started
  aasm_state :finished

  aasm_event :set_to_started do
    transitions :from => :draft, :to => :started
  end

  aasm_event :set_to_finished do
    transitions :from => :started, :to => :finished
  end

  scope :draft,    where( state: 'draft'    )
  scope :started,  where( state: 'started'  )
  scope :finished, where( state: 'finished' )

  before_save :set_maximum_score


  def points
    self[:points]|| 0
  end

  def passed?
    self.finished? && self.game_details.any?
  end

  def get_points user_answer_id
    self.points += (game_details.joins(:answer).where("answers.id= ? AND answers.correct = ?", user_answer_id, true).count) *10
  end

  def set_maximum_score
    self.max_score = self.quizz.questions.count * 10
  end

  def total_score
    if self.max_score
      self.quizz ? self.max_score : 1
    else
      if self.quizz
        self.quizz.questions.count * 10
      else
        10
      end
    end
  end

  def played_game
    Game.where("quizz_id = ?", self.quizz.id).count
  end

  def game_score_percent
    (self.points * 100.0/self.total_score).round(2)
  end

  def other_players
    # Take only unique and exclude currecnt_user
    players = self.quizz.games.finished.select{|game| self.user_id != game.user_id}.map{|g| g.user_id}.count
  end

  def other_games_scores
    scores = self.quizz.games.finished.inject([]){|arr, game| arr << game.game_score_percent if game.id != self.id; arr}
  end
end
