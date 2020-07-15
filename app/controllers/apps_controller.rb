class AppsController < ApplicationController
  def new
    @favorites = favorite.favorite_pets.map do |pet|
      Pet.find(pet[0])
    end 
  end

  def create
    application = App.new(app_params)
    if application.save
      params[:favorite_pets].each do |pet_id|
        PetApp.create(pet_id: pet_id, app_id: application.id)
        session[:favorite].delete(pet_id)
      end
      flash[:notice] = "Application submitted successfully."
      redirect_to "/favorites"
    else
      flash[:error] = "Application not submitted. Please fill out all required fields"
      redirect_to "/apps/new"
    end
  end

  def show
    @app = App.find(params[:id])
  end

  private

  def app_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
