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
        can permission.action.to_sym, permission.subject_class.constantize, :id => permission.subject_id
      end
    end
  end
end
