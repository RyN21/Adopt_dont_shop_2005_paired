class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
    if !@pet.status
      petapp = @pet.pet_apps.find_by(approved: "approved")
      @app = App.find(petapp.app_id)
    end
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    @shelter = Shelter.find(params[:id])
    pet = @shelter.pets.create(pet_params)
    redirect_to "/shelters/#{@shelter.id}/pets"
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    @pet = Pet.find(params[:id])
    @pet.update(pet_params)
    redirect_to "/pets/#{@pet.id}"
  end

  def destroy
    Pet.destroy(params[:id])
    redirect_to "/pets"
  end

  private

  def pet_params
    params.permit(:name, :age, :sex, :description, :image, :status)
  end
end
