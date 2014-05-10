class Game < ActiveRecord::Base
  include AASM

  attr_accessible :user_id, :quizz_id

  belongs_to :user
  belongs_to :quizz
  has_many :game_details

  scope :passed_games, joins(:game_details).where("points IS NOT NULL").group("games.id").order("games.created_at ASC")
  scope :created_games, where("points IS NULL").group("id").order("games.created_at ASC")
  
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
      #TODO: Fix this
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
    games = self.other_games_by_quizz self.quizz_id
    # Take only unique and exclude currecnt_user
    players = games.finished.select{|game| self.user_id != game.user_id}.map{|g| g.user_id}.count
  end

  def other_games_by_quizz id
    Game.where('quizz_id = ?', id)
  end

  def other_games_scores game_id, quizz_id
    scores = []
    games = self.other_games_by_quizz quizz_id
    games.finished.each do |game|
      if game.id != game_id
        scores << game.game_score_percent
      end
    end
    scores
  end
 
end
