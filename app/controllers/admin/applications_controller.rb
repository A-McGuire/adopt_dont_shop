class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    # @pet_application = @application.pet_applications[0]
    
    # binding.pry
  end

  def update
    application = Application.find(params[:id])
    pet_application_id = application.pet_applications[0].id
    pet_application = PetApplication.find(pet_application_id)
    pet_application.update(status: params[:app_status])
    # binding.pry
    redirect_to "/admin/applications/#{application.id}"
    # application.update(application_params)
    # redirect_to "/applications/#{application.id}"
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end