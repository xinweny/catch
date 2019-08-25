class CatPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    record.colony.nil? ? true : user_is_admin? || user_is_member?
  end

  def update?
    user_is_admin? || user_is_member?
  end

  def destroy?
    user_is_admin?
  end

  private

  def user_is_admin?
    return false if record.colony.nil?

    record.colony.admins.include?(user)
  end

  def user_is_member?
    user.colonies.include?(record.colony)
  end
end
