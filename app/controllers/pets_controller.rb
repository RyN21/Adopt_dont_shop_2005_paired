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
    shelter = Shelter.find(params[:id])

    @pet = shelter.pets.new(pet_params)
    if @pet.save
      redirect_to "/shelters/#{shelter.id}/pets"
    else @pet.errors.any?
      flash.alert = @pet.errors.full_messages.each do |msg|
        msg
      end
      redirect_to "/shelters/#{shelter.id}/pets/new"
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    @pet = Pet.find(params[:id])
    @pet.update(pet_params)
    if @pet.save
      redirect_to "/pets/#{@pet.id}"
    else @pet.errors.any?
      flash.alert = @pet.errors.full_messages.each do |msg|
        msg
      end
      redirect_to "/pets/#{@pet.id}/edit"
    end
  end

  def destroy
    if session[:favorite] == nil
      Pet.destroy(params[:id])
      redirect_to "/pets"
    elsif session[:favorite].include?(params[:id])
      session[:favorite].delete(params[:id])
      Pet.destroy(params[:id])
      redirect_to "/pets"
    else
      Pet.destroy(params[:id])
      redirect_to "/pets"
    end
  end

  private

  def pet_params
    params.permit(:name, :age, :sex, :description, :image, :status)
  end
end
