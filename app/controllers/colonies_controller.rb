class ColoniesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show search_cats]
  before_action :set_colony, only: %i[show edit update destroy]
  before_action :set_cat_markers, only: %i[new create edit update search_cats]


  def index
    if params[:query].present?
      @colonies = policy_scope(Colony).near(params[:query], 5)
    else
      @colonies = policy_scope(Colony).geocoded
    end
    authorize @colonies
    @markers = @colonies.map do |colony|
      {
        lat: colony.latitude,
        lng: colony.longitude,
        radius: colony.radius,
        infoWindow: { content: render_to_string(partial: "/colonies/info_window", locals: { colony: colony }) },
        image_url: helpers.asset_url('parktwo.svg')
      }
    end
  end

  def show
    @cat = Cat.new(colony: @colony)
    @event = Event.new(colony: @colony)
    @association = Association.find_by(user: current_user, colony: @colony)
    @association = Association.new(user: current_user, colony: @colony) if @association.nil?
  end

  def new
    @colony = Colony.new
    authorize @colony
  end

  def create
    @colony = Colony.new(colony_params)
    authorize @colony
    if @colony.save
      @colony.update_cats(params[:colony][:cat_ids])
      Association.create!(admin: true, user: current_user, colony: @colony)
      redirect_to colony_path(@colony)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @colony.update(colony_params)
    authorize @colony
    if @colony.save
      redirect_to colony_path(@colony)
    else
      render :edit
    end
  end

  def destroy
    @colony.destroy
    redirect_to(colonies_path)
  end

  def search_cats
    authorize Colony.new
    respond_to do |format|
      format.js
      format.html { render 'colonies/cat_map' }
    end
  end

  private

  def colony_params
    params.require(:colony).permit(:name, :address, :description, :radius, :photo, :cats)
  end

  def set_colony
    @colony = Colony.find(params[:id])
    authorize @colony
  end

  def set_cat_markers
    if params[:location].nil?
      @cats = Cat.where(colony_id: nil).geocoded
    else
      @cats = Cat.where(colony_id: nil).geocoded.near(params[:location], 5)
    end

    @markers = @cats.map do |cat|
      {
        lat: cat.latitude,
        lng: cat.longitude,
        infoWindow: { content: render_to_string(partial: "/colonies/form_info_window", locals: { cat: cat }) }
        # image_url: helpers.asset_url(‘file in the assets/images folder’)
      }
    end
    p @markers
  end
end
