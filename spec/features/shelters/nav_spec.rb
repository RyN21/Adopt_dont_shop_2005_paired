require 'rails_helper'

RSpec.describe "Navigation Pane" do
  it "has links to the shelter index on every page" do
    shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    dog = Pet.create!(name: "Jake", age: 4, sex: "male", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: shelter_1.id)

    visit "/shelters"
    click_on "All Shelters"
    expect(current_path).to eq("/shelters")

    visit "/shelters/new"
    click_on "All Shelters"
    expect(current_path).to eq("/shelters")

    visit "/shelters/#{shelter_1.id}"
    click_on "All Shelters"
    expect(current_path).to eq("/shelters")

    visit "/shelters/#{shelter_1.id}/edit"
    click_on "All Shelters"
    expect(current_path).to eq("/shelters")

    visit "/shelters/#{shelter_1.id}/pets"
    click_on "All Shelters"
    expect(current_path).to eq("/shelters")

    visit "/shelters/#{shelter_1.id}/pets/new"
    click_on "All Shelters"
    expect(current_path).to eq("/shelters")

    visit "/pets"
    click_on "All Shelters"
    expect(current_path).to eq("/shelters")

    visit "/pets/#{dog.id}"
    click_on "All Shelters"
    expect(current_path).to eq("/shelters")

    visit "/pets/#{dog.id}/edit"
    click_on "All Shelters"
    expect(current_path).to eq("/shelters")
  end
end
