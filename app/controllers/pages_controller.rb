class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home search]

  def home
  end

  def uikit
  end

  def dashboard
  end

  def search
    PgSearch::Multisearch.rebuild(Colony)
    PgSearch::Multisearch.rebuild(Event)
    PgSearch::Multisearch.rebuild(User)

    @results = PgSearch.multisearch(params[:query])
    @colonies = @results.select { |result| result.searchable_type == 'Colony' }
    @events = @results.select { |result| result.searchable_type == 'Event' }
    @users = @results.select { |result| result.searchable_type == 'User' }
  end
end
