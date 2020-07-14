require 'rails_helper'

RSpec.describe "shelters index page", type: :feature do
  before :each do
    @shelter_1 = Shelter.create(name: "Hope", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    @shelter_2 = Shelter.create!(name: "Paw Pals", address: "66 Wall Street", city: "Denver", state: "CO", zip_code: 80204)

  end

  it "can see all shelters names" do

    visit "/shelters"

    expect(page).to have_content("Hope")
    expect(page).to have_content("Paw Pals")

    click_on "Edit Hope"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")

    visit "/shelters"
    click_button "Delete Hope"
    expect(page).to_not have_content("Hope")
    click_on "Edit Paw Pals"
    expect(current_path).to eq("/shelters/#{@shelter_2.id}/edit")
  end
end
