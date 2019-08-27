class ParticipationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    return false if user_joined?

    user_is_member?
  end

  def destroy?
    user_joined?
  end

  private

  def user_joined?
    return false if user.nil?

    Participation.all.include?(record)
  end

  def user_is_member?
    record.event.colony.users.include?(user)
  end
end
