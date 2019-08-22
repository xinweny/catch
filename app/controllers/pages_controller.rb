class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]

  def home
  end

  def uikit
  end

  def dashboard
  end
end
