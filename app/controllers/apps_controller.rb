class AppsController < ApplicationController
  def new
    @favorites = favorite.favorite_pets.map do |pet|
      Pet.find(pet[0])
    end
  end

  def create
    application = App.new(app_params)
    if application.save
      flash[:notice] = "Application submitted successfully."
      params[:favorite_pets].each do |pet_id|
        session[:favorite].delete(pet_id)
      end
      redirect_to "/favorites"
    else
      flash[:error] = "Application not submitted. Please fill out all required fields"
      redirect_to "/apps/new"
    end
  end

  private

  def app_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
