require 'rails_helper'

RSpec.describe "shelters index page", type: :feature do
  it "can see all shelters names" do
    shelter_1 = Shelter.create(name: "Hope")
    shelter_2 = Shelter.create(name: "Paw Pals")

    visit "/shelters"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_2.name)

    click_on "Edit Hope"
    expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")

    visit "/shelters"
    click_button "Delete Hope"
    expect(page).to_not have_content(shelter_1.name)

    click_on "Edit Paw Pals"
    expect(current_path).to eq("/shelters/#{shelter_2.id}/edit")
  end
end
