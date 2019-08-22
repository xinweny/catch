class ColonyPolicy < ApplicationPolicy
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
    true
  end

  def update?
    user_is_admin?
  end

  def destroy?
    user_is_admin?
  end

  def search_cats?
    true
  end

  private

  def user_is_admin?
    record.admins.include?(user)
  end
end
