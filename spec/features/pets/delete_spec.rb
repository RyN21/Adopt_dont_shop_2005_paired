require 'rails_helper'

RSpec.describe "pet show page" do
  it "allows visitor to delete pet" do
    shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    dog = Pet.create!(name: "Jake", age: 4, sex: "male", description: "He's a dog", status: "Adoptable", shelter_id: shelter_1.id, image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2")

    visit "/pets"
    expect(page).to have_content("Jake")

    visit "/pets/#{dog.id}"
    expect(page).to have_content("Jake")

    click_on "Delete Pet"

    expect(current_path).to eq("/pets")
    
    expect(page).to_not have_content(dog.name)
  end
end
# User Story 12, Pet Delete
# Then a 'DELETE' request is sent to '/pets/:id',
# the pet is deleted,
# and I am redirected to the pet index page where I no longer see this pet
