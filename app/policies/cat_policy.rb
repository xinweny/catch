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
    record.colony.nil? ? true : user_is_admin?
  end

  def update?
    user_is_admin?
  end

  def destroy?
    user_is_admin?
  end

  # def search_cats?
  #   binding.pry
  #   true
  # end

  # def set_cat_markers
  #   binding.pry
  #   true
  # end

  private

  def user_is_admin?
    return false if record.colony.nil?

    record.colony.admins.include?(user)
  end
end
