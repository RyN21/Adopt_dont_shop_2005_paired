require 'rails_helper'

RSpec.describe "Shelter show page" do
  before :each do
    @shelter_1 = Shelter.create(name: "Hope", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    @shelter_2 = Shelter.create(name: "Paw Pals", address: "666 Wall Street", city: "Denver", state: "CO", zip_code: 80204)
    dog = Pet.create!(name: "Jake", age: 4, sex: "male", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: @shelter_1.id)
    dog2 = Pet.create!(name: "Charley", age: 5, sex: "male", image: "https://www.pennmedicine.org/news/-/media/images/pr%20news/news/2018/may/summerdog.ashx?h=263&w=400&la=en", shelter_id: @shelter_1.id)
    cat = Pet.create!(name: "Finn", age: 2, sex: "male", image: "https://www.lifeinnorway.net/wp-content/uploads/2018/08/male-norwegian-forest-cat.jpg", shelter_id: @shelter_1.id)
    cat2 = Pet.create!(name: "Smudge", age: 6, sex: "female", image: "https://www.aljazeera.com/mritems/imagecache/mbdxxlarge/mritems/Images/2020/4/13/ecab8c7af42a439d9043b0ade6e1f05b_18.jpg", shelter_id: @shelter_2.id)

    review_1 = @shelter_1.reviews.create!(title: "Great shelter!", rating: 4, content: "This shelter has done a great job at pairing me with my new best friend", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: @shelter_1.id)
    review_2 = @shelter_1.reviews.create!(title: "Good shelter!", rating: 5, content: "So happy with the way this shelter has worked", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: @shelter_1.id)
  end

  it "shows name, address, city, state, zip for a particular shelter" do

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_1.address)
    expect(page).to have_content(@shelter_1.city)
    expect(page).to have_content(@shelter_1.state)
    expect(page).to have_content(@shelter_1.zip_code)
    expect(page).not_to have_content(@shelter_2.name)
  end

  it "has a link to the shelters pets page" do

    visit "/shelters/#{@shelter_1.id}"

    click_on "Available Pets"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
  end

  it "displays shelters statistics. " do

    visit "/shelters/#{@shelter_1.id}"

    expect(@shelter_1.pet_count).to eq(3)
    expect(@shelter_1.average_rating).to eq(4.5)
    # expect(@shelter_1.number_of_applications_on_file).to eq(2)
  end
end


# *****************************
# *****************************
# *****************************
# *****************************

# - number of applications on file for that shelter

# *****************************
# *****************************
# *****************************
# *****************************
