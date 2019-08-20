class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    user_is_admin?
  end

  private

  def user_is_admin?
    record.colony.admins.include?(user)
  end
end
