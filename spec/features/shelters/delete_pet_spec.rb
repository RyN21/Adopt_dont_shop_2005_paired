require 'rails_helper'

RSpec.describe "delete pet" do
  it "can be deleted from shelter_pets index page or pets index page" do
    shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    shelter_2 = Shelter.create!(name: "New Friends", address: "66 Wall Street", city: "Denver", state: "CO", zip_code: 80204)
    dog = Pet.create!(name: "Jake", age: 4, sex: "male", status: true, image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: shelter_1.id)
    dog2 = Pet.create!(name: "Charley", age: 5, sex: "male", status: true, image: "https://www.pennmedicine.org/news/-/media/images/pr%20news/news/2018/may/summerdog.ashx?h=263&w=400&la=en", shelter_id: shelter_2.id)
    cat = Pet.create!(name: "Finn", age: 2, sex: "male", status: true, image: "https://www.lifeinnorway.net/wp-content/uploads/2018/08/male-norwegian-forest-cat.jpg", shelter_id: shelter_1.id)
    cat2 = Pet.create!(name: "Smudge", age: 6, sex: "female", status: true, image: "https://www.aljazeera.com/mritems/imagecache/mbdxxlarge/mritems/Images/2020/4/13/ecab8c7af42a439d9043b0ade6e1f05b_18.jpg", shelter_id: shelter_2.id)

    visit "/pets"

    expect(page).to have_selector(:link_or_button, 'Delete Jake')
    expect(page).to have_selector(:link_or_button, 'Delete Charley')
    expect(page).to have_selector(:link_or_button, 'Delete Finn')
    expect(page).to have_selector(:link_or_button, 'Delete Smudge')

    click_button "Delete Smudge"

    expect(current_path).to eq("/pets")
    expect(page).to_not have_selector(:link_or_button, 'Delete Smudge')

    visit "/shelters/#{shelter_1.id}/pets"
    expect(page).to have_selector(:link_or_button, 'Delete Jake')
    expect(page).to have_selector(:link_or_button, 'Delete Finn')
    click_button "Delete Finn"
    expect(current_path).to eq("/pets")
    expect(page).to_not have_selector(:link_or_button, 'Delete Finn')
  end
end

# When I visit the pets index page or a shelter pets index page
# Next to every pet, I see a link to delete that pet
# When I click the link
# I should be taken to the pets index page where I no longer see that pet
