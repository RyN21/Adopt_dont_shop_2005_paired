require 'rails_helper'

RSpec.describe "Remove a favorite from Favorites Page" do
  before :each do
    @shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    @dog = Pet.create!(name: "Jake", age: 4, sex: "male", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: @shelter_1.id)
    @dog2 = Pet.create!(name: "Charley", age: 5, sex: "male", image: "https://www.pennmedicine.org/news/-/media/images/pr%20news/news/2018/may/summerdog.ashx?h=263&w=400&la=en", shelter_id: @shelter_1.id)
  end
  it "there is a button to remove pet from favorites and it does indeed remove the per" do

    visit "/pets/#{@dog.id}"

    within(".show") do
      click_button "Add to Favorites"
    end

    visit "/pets/#{@dog2.id}"

    within(".show") do
      click_button "Add to Favorites"
    end

    expect(page).to have_content("Favorites: 2")

    visit '/favorites'

    within("#pet-#{@dog.id}") do
      click_button "Remove from favorites"
    end

    expect(page).to_not have_content(@dog.name)
    expect(page).to have_content("Favorites: 1")

  end
end




# Next to each pet, I see a button or link to remove that pet from my favorites
# When I click on that button or link to remove a favorite
# A delete request is sent to "/favorites/:pet_id"
# And I'm redirected back to the favorites page where I no longer see that pet listed
# And I also see that the favorites indicator has decremented by 1
#
