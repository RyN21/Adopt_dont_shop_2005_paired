require 'rails_helper'

RSpec.describe 'Favorite indicator' do
  it "has a favorite indicator in navigation bar" do
    shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    shelter_2 = Shelter.create!(name: "New Friends", address: "66 Wall Street", city: "Denver", state: "CO", zip_code: 80204)
    dog = Pet.create!(name: "Jake", age: 4, sex: "male", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: shelter_1.id)
    dog2 = Pet.create!(name: "Charley", age: 5, sex: "male", image: "https://www.pennmedicine.org/news/-/media/images/pr%20news/news/2018/may/summerdog.ashx?h=263&w=400&la=en", shelter_id: shelter_2.id)
    cat = Pet.create!(name: "Finn", age: 2, sex: "male", image: "https://www.lifeinnorway.net/wp-content/uploads/2018/08/male-norwegian-forest-cat.jpg", shelter_id: shelter_1.id)
    cat2 = Pet.create!(name: "Smudge", age: 6, sex: "female", image: "https://www.aljazeera.com/mritems/imagecache/mbdxxlarge/mritems/Images/2020/4/13/ecab8c7af42a439d9043b0ade6e1f05b_18.jpg", shelter_id: shelter_2.id)

    visit '/'

    expect(page)to. have_content("Favorites")
    expect
  end
end


User Story 8, Favorite Indicator

As a visitor
I see a favorite indicator in my navigation bar
The favorite indicator shows a count of pets in my favorites list
I can see this favorite indicator from any page in the application
