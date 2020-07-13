class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.new(session[:favorite])
    @pets_ids = @favorites.favorite_pets.keys
    @pets = @pets_ids.map do |id|
      Pet.find(id)
    end
    @apps = App.all
    # Only send one object to view
  end

  def update
    pet = Pet.find(params[:pet_id])
    favorite.add_pet(pet.id)
    session[:favorite] = @favorite.favorite_pets
    flash[:notice] = "You have added #{pet.name} to your favorites."
    redirect_to "/pets/#{pet.id}"
  end

  def remove
    session[:favorite].delete(params[:pet_id])
    redirect_to "/favorites"
  end

  def remove_all
    session[:favorite] = {}
    redirect_to "/favorites"
  end
end
