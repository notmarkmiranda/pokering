class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, League
    return unless user
    can [:new, :create], League if user
    can [:edit, :update, :destroy], League, user_id: user.id

    user.permissions.each do |permission|
      if permission.subject_id.nil?
        can permission.action.to_sym, permission.subject_class.constantize
      else
        subject_class = permission.subject_class.constantize
        can permission.action.to_sym, subject_class, :id => permission.subject_id.to_i
        can :manage, Season, league_id: permission.resource_id if league_manager?(permission, subject_class)
        can :manage, Game, season: { league_id: permission.resource_id } if league_manager?(permission, subject_class)
        can :manage, Player, game: { season: { league_id: permission.resource_id } }
      end
    end
  end

  private

  def league_manager?(permission, subject_class)
    subject_class == League && permission.action == 'manage'
  end
end
