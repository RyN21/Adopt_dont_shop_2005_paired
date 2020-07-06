require 'rails_helper'

RSpec.describe 'Shelter Update' do
  it "can edit a specific shelter info" do
    shelter_1 = Shelter.create(name: "Hope", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)

    visit "/shelters/#{shelter_1.id}"

    expect(page).to_not have_content("New Friends")

    click_on "Update Shelter"

    expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")

    fill_in :name, with: "New Friends"
    fill_in :address, with: "7862 Ivy Ct"
    fill_in :city, with: "Centennial"
    fill_in :state, with: "WY"
    fill_in :zip_code, with: 90210

    click_button "Update Shelter"

    expect(current_path).to eq("/shelters/#{shelter_1.id}")
    expect(page).to have_content("New Friends")
    expect(page).to have_content("7862 Ivy Ct")
    expect(page).to have_content("Centennial")
    expect(page).to have_content("WY")
    expect(page).to have_content("90210")
  end
end

# Then a `PATCH` request is sent to '/shelters/:id',
# the shelter's info is updated,
# and I am redirected to the Shelter's Show page where I see the shelter's updated info
