class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])  
    @pets = Pet.search(params[:search])
  end

  def new
  end

  def create
    if params[:adopt].present?
      application = Application.find(params[:id])
      application.pets << Pet.find(params[:adopt])
      redirect_to "/applications/#{application.id}"
      return
    end

    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:error] = application.errors.full_messages.to_sentence
      render :new
    end
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