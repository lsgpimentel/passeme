class Ability
  include CanCan::Ability

  def initialize(user)
    #Can manage Syllabuses which he created
    can :manage, Syllabus, user_id: user.id

    #Can only read Syllabuses which is public or he have explicit permissions to see
    can :read, Syllabus do |s|
      user.can_view?(s)
    end

    #Can only manage Groups which he created
    can :manage, Group do |g|
      user.created_groups.include?(g)
    end

    #Can only read groupś which he is a participant
    can :read, Group do |g|
      g.participants.include?(user)
    end


    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
