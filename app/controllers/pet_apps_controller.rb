class PetAppsController < ApplicationController
  def index
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:pet_id])
    petapp = PetApp.where(pet_id: pet.id, app_id: params[:app_id])
    if pet.status
      petapp.update(approved: "approved")
      pet.update(status: false)
      redirect_to "/pets/#{pet.id}"
    else
      petapp.update(approved: nil)
      pet.update(status: true)
      redirect_to "/apps/#{params[:app_id]}"
    end
  end
end
