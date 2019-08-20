class ColoniesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_colony, only: %i[show edit update destroy]

  def index
    @colonies = policy_scope(Colony)
    authorize @colonies
  end

  def show
    @cat = Cat.new(colony: @colony)
    @event = Event.new(colony: @colony)
  end

  def new
    @colony = Colony.new
    authorize @colony
  end

  def create
    @colony = Colony.new(colony_params)
    authorize @colony
    Association.create!(admin: true, user: current_user, colony: @colony)
    if @colony.save
      redirect_to colony_path(@colony)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @colony.update(colony_params)
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

  private

  def colony_params
    params.require(:colony).permit(:name, :address, :description, :radius)
  end

  def set_colony
    @colony = Colony.find(params[:id])
    authorize @colony
  end
end
