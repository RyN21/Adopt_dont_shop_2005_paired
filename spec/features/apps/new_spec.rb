require 'rails_helper'

RSpec.describe "new application page" do
  before :each do
    @shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    @shelter_2 = Shelter.create!(name: "New Friends", address: "66 Wall Street", city: "Denver", state: "CO", zip_code: 80204)
    @dog = Pet.create!(name: "Jake", age: 4, sex: "male", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: @shelter_1.id)
    @dog2 = Pet.create!(name: "Charley", age: 5, sex: "male", image: "https://www.pennmedicine.org/news/-/media/images/pr%20news/news/2018/may/summerdog.ashx?h=263&w=400&la=en", shelter_id: @shelter_2.id)
    @cat = Pet.create!(name: "Finn", age: 2, sex: "male", image: "https://www.lifeinnorway.net/wp-content/uploads/2018/08/male-norwegian-forest-cat.jpg", shelter_id: @shelter_1.id)
  end
  it "should show a form to choose from favorited pets and enter information to successfully submit application" do

    visit "/pets/#{@dog.id}"
    click_button "Add to Favorites"
    visit "/pets/#{@dog2.id}"
    click_button "Add to Favorites"
    expect(page).to have_content("Favorites: 2")

    visit "/favorites"
    click_on "Apply Now"
    expect(current_path).to eq("/apps/new")

    select(@dog.name)
    select(@dog2.name)
    fill_in :name, with: "Name"
    fill_in :address, with: "Address"
    fill_in :city, with: "City"
    fill_in :state, with: "State"
    fill_in :zip, with: "Zip"
    fill_in :phone_number, with: "Phone Number"
    fill_in :description, with: "Description"

    click_button "Submit"

    expect(current_path).to eq("/favorites")
    expect(page).to have_content("Application submitted successfully")
    within(".index") do
      expect(page).to_not have_content(@dog.name)
      expect(page).to_not have_content(@dog2.name)
    end
  end
  it "should flash error and return to new app when incomplete form" do
    visit "/pets/#{@dog.id}"
    click_button "Add to Favorites"
    visit "/pets/#{@dog2.id}"
    click_button "Add to Favorites"
    expect(page).to have_content("Favorites: 2")

    visit "/favorites"
    click_on "Apply Now"
    expect(current_path).to eq("/apps/new")

    select(@dog.name)
    fill_in :name, with: "Name"
    fill_in :address, with: "Address"
    fill_in :city, with: "City"
    fill_in :state, with: "State"
    fill_in :zip, with: "Zip"
    fill_in :phone_number, with: "Phone Number"

    click_button "Submit"

    expect(page).to have_content("Application not submitted")
    expect(current_path).to eq("/apps/new")
  end
end
