require 'rails_helper'

RSpec.describe "Navigation to shelter page" do
  it "allows users to click on shelter name from anywhere" do
    shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    shelter_2 = Shelter.create!(name: "New Friends", address: "66 Wall Street", city: "Denver", state: "CO", zip_code: 80204)
    dog = Pet.create!(name: "Jake", age: 4, sex: "male", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: shelter_1.id)
    dog2 = Pet.create!(name: "Charley", age: 5, sex: "male", image: "https://www.pennmedicine.org/news/-/media/images/pr%20news/news/2018/may/summerdog.ashx?h=263&w=400&la=en", shelter_id: shelter_2.id)

    visit "/shelters"
    click_on "Paw Pals"
    expect(current_path).to eq("/shelters/#{shelter_1.id}")

    visit "/shelters"
    click_on "New Friends"
    expect(current_path).to eq("/shelters/#{shelter_2.id}")

    visit "/shelters/#{shelter_1.id}/pets"
    click_on "Paw Pals"
    expect(current_path).to eq("/shelters/#{shelter_1.id}")

    visit "/shelters/#{shelter_2.id}/pets"
    click_on "New Friends"
    expect(current_path).to eq("/shelters/#{shelter_2.id}")

    visit "/pets"
    click_on "Paw Pals"
    expect(current_path).to eq("/shelters/#{shelter_1.id}")

    visit "/pets"
    click_on "New Friends"
    expect(current_path).to eq("/shelters/#{shelter_2.id}")

    visit "/pets/#{dog.id}"
    click_on "Paw Pals"
    expect(current_path).to eq("/shelters/#{shelter_1.id}")

    visit "/pets/#{dog2.id}"
    click_on "New Friends"
    expect(current_path).to eq("/shelters/#{shelter_2.id}")
  end
end
