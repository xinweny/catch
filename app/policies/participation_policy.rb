class ParticipationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    return false if user_joined?

    true
  end

  def destroy?
    user_joined?
  end

  private

  def user_joined?
    return false if user.nil?

    Participation.all.include?(record)
  end
end
