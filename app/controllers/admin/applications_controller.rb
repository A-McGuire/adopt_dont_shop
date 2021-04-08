class Admin::ApplicationsController < ApplicationController
  before_action(:set_application, only: [:show, :update])

  def set_application
    @application = Application.find(params[:id])
  end
  
  def show
    @application
  end

  def update
    pet_application = @application.find_pet_application(params[:pet]) 
    pet_application.update(status: params[:app_status]) #Should live in pet_applications_controller?
    redirect_to "/admin/applications/#{@application.id}"
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end