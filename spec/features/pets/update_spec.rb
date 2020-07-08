require 'rails_helper'

RSpec.describe "pet update page" do
  it "allows visitor to update pet data from the pet show page" do
    shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    dog = Pet.create!(name: "Jake", age: 4, sex: "male", description: "He's a dog", status: "Adoptable", shelter_id: shelter_1.id, image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2")

    visit "/pets/#{dog.id}"
    expect(page).to_not have_content("Mr. Chomps")

    click_on "Update Pet"

    expect(current_path).to eq("/pets/#{dog.id}/edit")

    fill_in :name, with: "Mr. Chomps"
    fill_in :age, with: 5
    fill_in :sex, with: "Female"
    fill_in :description, with: "She is a dog"
    fill_in :image, with: "https://www.pennmedicine.org/news/-/media/images/pr%20news/news/2018/may/summerdog.ashx?h=263&w=400&la=en"

    click_button "Update Pet"

    expect(current_path).to eq("/pets/#{dog.id}")
    expect(page).to_not have_content("Jake")
    expect(page).to have_content("Mr. Chomps")
    expect(page).to have_content("Age: 5")
    expect(page).to have_content("Sex: Female")
    expect(page).to have_content("She is a dog")

  end
end

# User Story 11, Pet Update
# Then a `PATCH` request is sent to '/pets/:id',
