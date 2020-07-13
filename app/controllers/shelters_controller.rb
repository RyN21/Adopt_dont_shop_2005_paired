class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
    @reviews = @shelter.reviews
  end

  def new
  end

  def create
    Shelter.create(shelter_params)
    redirect_to "/shelters"
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update(shelter_params)
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    shelter = Shelter.find(params[:id])
    shelter.reviews.delete_all
    shelter.destroy
    redirect_to "/shelters"
  end

  def pets_index
    @shelter = Shelter.find(params[:id])
    @pets = @shelter.adoptable_pets
  end

  private

  def shelter_params
    params.permit(:name, :address, :city, :state, :zip_code)
  end
end
