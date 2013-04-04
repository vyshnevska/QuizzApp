class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  has_many :games
  has_many :quizzs, :through => :games
  ROLES = %w[admin guest]
  validates :name, :presence => true, :uniqueness => true
  after_create :assign_role

  def is_admin
    admin
  end
private
  def assign_role
    if name == "nvyshnev"
      admin = true
    end
    save
  end


end
