class AssociationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    return false if user_is_admin? || user_is_member?

    true
  end

  def destroy?
    user_is_member?
  end

  private

  def user_is_member?
    return false if user.nil?

    Association.all.include?(record)
  end

  def user_is_admin?
    return false if user.nil?

    user.admin_groups.include?(record.colony)
  end
end
