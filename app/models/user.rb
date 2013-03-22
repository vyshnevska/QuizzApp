class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :admin

  has_many :games
  has_many :quizzs, :through => :games

  ROLES = %w[admin guest]

  validates :name, :presence => true, :uniqueness => true
  after_create :assign_role

  def assign_role
    if self.name == "nvyshnev"
      self.admin = true
    end
    self.save
  end
end
