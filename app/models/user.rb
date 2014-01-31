class User < ActiveRecord::Base
   devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :role, :max_score
  attr_accessible :provider, :uid, :name

  has_many :games
  has_many :quizzs, :through => :games
  has_many :messages
  ROLES = %w[admin guest simple_user]
  
  #Friendship
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  scope :without_user, lambda{|user| user ? {:conditions => ["id != ?", user.id]} : {} }

  validates :name, :presence => true, :uniqueness => true
  after_create :assign_role

  def assigned_games
    self.games.count
  end

  def passed_games
    Game.joins(:game_details).where("points IS NOT NULL AND user_id = ?", self.id)
  end

  def total_score
    self.passed_games.map{|game| game.points}.inject {|sum, points| sum + points }
  end

  def maximum_score
    self.passed_games.map{|game| game.total_score}.inject {|sum, score| sum + score }
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email,
                           password:Devise.friendly_token[0,20]
                           )
    end
    user
  end

  def rank
    # TODO: implement this
  end

  def has_access_to_view?
    self.admin?
  end

private
  def assign_role
    self.role = "guest" unless role.nil?
  end
end
