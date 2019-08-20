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
  end

  def update?
  end

  def destroy?
  end

  private

  def user_is_admin?
    record.associations.find_by_user(user).admin?
  end
end
