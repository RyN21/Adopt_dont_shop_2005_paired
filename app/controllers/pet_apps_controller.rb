class PetAppsController < ApplicationController
  def index
    @pet = Pet.find(params[:id])
  end
end
