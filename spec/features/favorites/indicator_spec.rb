require 'rails_helper'

RSpec.describe "Favorite Indicator" do
  it "is visibile in the nav bar on every page" do
    @shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    @dog = Pet.create!(name: "Jake", age: 4, sex: "male", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: @shelter_1.id)
    @dog2 = Pet.create!(name: "Charley", age: 5, sex: "male", image: "https://www.pennmedicine.org/news/-/media/images/pr%20news/news/2018/may/summerdog.ashx?h=263&w=400&la=en", shelter_id: @shelter_1.id)
    # favorites = Favorite.new(pet: 1)

    visit "/pets/#{@dog.id}"

    expect(page).to have_content("Favorites: 0")

    click_button "Add to Favorites"

    expect(page).to have_content("Favorites: 1")

    visit "/pets/#{@dog2.id}"

    click_button "Add to Favorites"

    expect(page).to have_content("Favorites: 2")
  end
end
