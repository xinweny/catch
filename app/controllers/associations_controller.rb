class AssociationsController < ApplicationController
  def create
    @colony = Colony.find(params[:colony_id])
    @association = Association.new(user: current_user, colony: @colony)
    authorize @association
    @association.save
    redirect_to colony_path(@colony)
  end

  def destroy
    @association = Association.find(params[:id])
    authorize @association
    colony = @association.colony
    @association.destroy
    redirect_to colony_path(colony)
  end
end
