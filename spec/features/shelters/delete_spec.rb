require 'rails_helper'

RSpec.describe "When visiting a shelter show page" do
  before :each do
    @shelter_1 = Shelter.create(name: "Hope", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    @review_1 = @shelter_1.reviews.create!(title: "Great shelter!", rating: 4, content: "This shelter has done a great job at pairing me with my new best friend", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: @shelter_1.id)
    @review_2 = @shelter_1.reviews.create!(title: "Good shelter!", rating: 5, content: "So happy with the way this shelter has worked", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: @shelter_1.id)

  end

  it "can destroy the shelter" do
    @dog = Pet.create!(name: "Jake", age: 4, sex: "male", status: true, image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: @shelter_1.id)

    visit "/pets/#{@dog.id}"

    click_button "Add to Favorites"

    visit "/shelters"

    expect(page).to have_content(@shelter_1.name)

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_content(@shelter_1.name)

    click_button "Delete Shelter"

    expect(current_path).to eq("/shelters")
    expect(page).to_not have_content(@shelter_1.name)
    expect(page).to_not have_content("Favorites: 1")
  end

  it "deletes all the reviews associated with that shelter when shelter is deleted" do

    visit "/shelters/#{@shelter_1.id}"

    click_button "Delete Shelter"

    expect(current_path).to eq("/shelters")
    expect(page).to_not have_content(@shelter_1.name)
    expect(page).to_not have_content(@review_1.title)
    expect(page).to_not have_content(@review_2.title)
  end

  it "cannot delete shelter if pet adoption status is pending" do
    @dog = Pet.create!(name: "Jake", age: 4, sex: "male", status: true, image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: @shelter_1.id)
    @dog2 = Pet.create!(name: "Charley", age: 5, sex: "male", status: true, image: "https://www.pennmedicine.org/news/-/media/images/pr%20news/news/2018/may/summerdog.ashx?h=263&w=400&la=en", shelter_id: @shelter_1.id)
    @cat = Pet.create!(name: "Finn", age: 2, sex: "male", status: true, image: "https://www.lifeinnorway.net/wp-content/uploads/2018/08/male-norwegian-forest-cat.jpg", shelter_id: @shelter_1.id)
    @cat2 = Pet.create!(name: "Smudge", age: 6, sex: "female", status: false, image: "https://www.aljazeera.com/mritems/imagecache/mbdxxlarge/mritems/Images/2020/4/13/ecab8c7af42a439d9043b0ade6e1f05b_18.jpg", shelter_id: @shelter_1.id)

    visit "/shelters/#{@shelter_1.id}"

    click_button "Delete Shelter"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    expect(page).to have_content("Cannot delete shelter. Pets are pending")
    expect(page).to have_content(@shelter_1.name)

  end
end
