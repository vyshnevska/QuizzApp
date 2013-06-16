class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
      user ||= User.new # guest user (not logged in)
      if user.role == "admin"
        can :manage, :all
      elsif user.role == "simple_user"
        can :manage, [Quizz, Game]
      elsif user.role == "guest"
        can :read, :all
      end
   end
end
