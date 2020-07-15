require 'rails_helper'

RSpec.describe "pet show page" do
  before :each do
    @shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    @dog = Pet.create!(name: "Jake", age: 4, sex: "male", description: "He's a dog", status: true, shelter_id: @shelter_1.id, image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2")
    @dog2 = Pet.create!(name: "Charley", age: 5, sex: "male", description: "Well trained dog", image: "https://www.pennmedicine.org/news/-/media/images/pr%20news/news/2018/may/summerdog.ashx?h=263&w=400&la=en", shelter_id: @shelter_1.id, status: true)
  end

  it "allows visitor to delete pet" do

    visit "/pets/#{@dog2.id}"

    within(".show") do
      click_button "Add to Favorites"
    end

    visit "/pets"
    expect(page).to have_content("Jake")

    visit "/pets/#{@dog.id}"
    expect(page).to have_content("Jake")

    click_on "Delete Pet"

    expect(current_path).to eq("/pets")

    expect(page).to_not have_content(@dog.name)
  end

  it "when a pet is deleted from the database, it is also removed from any favorites list" do

    visit "/pets/#{@dog2.id}"

    within(".show") do
      click_button "Add to Favorites"
    end

    visit "/pets/#{@dog.id}"

    within(".show") do
      click_button "Add to Favorites"
    end

    visit "/pets/#{@dog.id}"

    expect(page).to have_content("Favorites: 2")

    click_on "Delete Pet"

    expect(current_path).to eq("/pets")
    expect(page).to_not have_content(@dog.name)
    expect(page).to have_content(@dog2.name)
    expect(page).to have_content("Favorites: 1")
  end
end
