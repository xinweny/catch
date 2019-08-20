class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def index
    @users = policy_scope(User)
  end

  def show
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end
end
