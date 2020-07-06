require 'rails_helper'

RSpec.describe "When visiting a shelter show page" do
  it "can destroy the shelter" do
    shelter_1 = Shelter.create(name: "Hope", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)

    visit "/shelters"

    expect(page).to have_content(shelter_1.name)

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content(shelter_1.name)

    click_button "Delete Shelter"

    expect(current_path).to eq("/shelters")
    expect(page).to_not have_content(shelter_1.name)
  end
end


# User Story 6, Shelter Delete

# As a visitor
# When I visit a shelter show page
# Then I see a link to delete the shelter
# When I click the link "Delete Shelter"
# Then a 'DELETE' request is sent to '/shelters/:id',
# the shelter is deleted,
# and I am redirected to the shelter index page where I no longer see this shelter
