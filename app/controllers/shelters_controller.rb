class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
    @reviews = @shelter.reviews # call in view
  end

  def new
  end

  def create
    shelter = Shelter.new(shelter_params)
    if shelter.save
      redirect_to "/shelters"
    else
      flash.alert = "Need additional information"
      redirect_to '/shelters/new'
    end
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    if shelter.update(shelter_params)
      redirect_to "/shelters/#{shelter.id}"
    else
      flash.alert = "Need additional information"
      redirect_to "/shelters/#{shelter.id}/edit"
    end
  end

  def destroy
    shelter = Shelter.find(params[:id])
    if shelter.pending_pets == []
      shelter.reviews.delete_all
      shelter.pets.delete_all
      shelter.destroy
      redirect_to "/shelters"
    else
      flash.alert = "Cannot delete shelter. Pets are pending"
      redirect_to "/shelters/#{shelter.id}"
    end
  end

  def pets_index
    @shelter = Shelter.find(params[:id])
    @pets = @shelter.adoptable_pets #call in view
  end

  private

  def shelter_params
    params.permit(:name, :address, :city, :state, :zip_code)
  end
end
