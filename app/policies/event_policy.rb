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

  def update?
    user_is_admin?
  end

  def destroy?
    user_is_admin?
  end

  def update_cats?
    user_is_participant?
  end

  private

  def user_is_admin?
    record.colony.admins.include?(user)
  end

  def user_is_participant?
    record.users.include?(user)
  end
end
