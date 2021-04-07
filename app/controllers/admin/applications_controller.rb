class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    application = Application.find(params[:id])
    pet_application = PetApplication.find_pet_application(params[:pet], application)
    pet_application.update(status: params[:app_status])
    redirect_to "/admin/applications/#{application.id}"
    # pet_application_id = application.pet_applications[0].id
    # pet_application = PetApplication.find(pet_application_id)
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end