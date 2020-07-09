class FavoritesController < ApplicationController
  def index
    @pets = Pet.all
    @favorites = Favorite.new(session[:favorite])
  end

  def update
    pet = Pet.find(params[:pet_id])
    favorite.add_pet(pet.id)
    session[:favorite] = @favorite.favorite_pets
    flash[:notice] = "You have added #{pet.name} to your favorites."
    redirect_to "/pets/#{pet.id}"
  end
end
