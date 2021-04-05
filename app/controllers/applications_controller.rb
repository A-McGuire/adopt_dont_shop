class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])  
    @pets = Pet.search(params[:search])
    if params[:adopt].present?
      @pets_to_adopt = @application.pets << Pet.find(params[:adopt])
    end
  end

  def new
  end

  def create
    application = Application.create(application_params)
    redirect_to "/applications/#{application.id}"
  end

  def update
    application = Application.find(params[:id])
    application.update(application_params)
    redirect_to "/applications/#{application.id}"
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end