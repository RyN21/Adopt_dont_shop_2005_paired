require 'rails_helper'

RSpec.describe "When a user adds pets to favorites" do
  before :each do
    @shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    @dog = Pet.create!(name: "Jake", age: 4, sex: "male", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: @shelter_1.id, status: true)
    @dog2 = Pet.create!(name: "Charley", age: 5, sex: "male", image: "https://www.pennmedicine.org/news/-/media/images/pr%20news/news/2018/may/summerdog.ashx?h=263&w=400&la=en", shelter_id: @shelter_1.id, status: true)
  end

  it "displays a message and updates favorites count" do

    visit "/pets/#{@dog.id}"

    within(".show") do
      click_button "Add to Favorites"
    end

    expect(current_path).to eq("/pets/#{@dog.id}")
    expect(page).to have_content("You have added #{@dog.name} to your favorites.")
    expect(page).to have_content("Favorites: 1")
  end

  it "can't favorite a pet more than once" do
    visit "/pets/#{@dog.id}"

    within(".show") do
      click_button "Add to Favorites"
    end

    expect(page).to have_content("Favorites: 1")

    within(".show") do
      click_button "Add to Favorites"
    end

    expect(page).to have_content("Favorites: 1")
  end
end
