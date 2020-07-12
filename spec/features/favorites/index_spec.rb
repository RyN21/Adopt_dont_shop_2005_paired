require 'rails_helper'


RSpec.describe "Favorite Index Page" do
  before :each do
    @shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    @dog = Pet.create!(name: "Jake", age: 4, sex: "male", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: @shelter_1.id)
    @dog2 = Pet.create!(name: "Charley", age: 5, sex: "male", image: "https://www.pennmedicine.org/news/-/media/images/pr%20news/news/2018/may/summerdog.ashx?h=263&w=400&la=en", shelter_id: @shelter_1.id)
  end
  it "displays a message and updates favorites count" do

    visit "/pets/#{@dog.id}"

    within(".show") do
      click_button "Add to Favorites"
    end

    visit "/pets/#{@dog2.id}"

    within(".show") do
      click_button "Add to Favorites"
    end

    visit '/favorites'

    expect(page).to have_content("Jake")
    expect(page).to have_content("Charley")
    expect(page).to have_xpath("//img[contains(@src,'#{@dog.image}')]")
    expect(page).to have_xpath("//img[contains(@src,'#{@dog2.image}')]")
  end

  it "has link to favorites index page from navigation bar" do

    visit "/pets/#{@dog.id}"
    click_button "Add to Favorites"


    visit '/shelters'

    click_on "Favorites:"

    expect(current_path).to eq('/favorites')

    visit '/pets'

    click_on "Favorites:"

    expect(current_path).to eq('/favorites')
  end

  it "has no favorites page" do
    visit '/favorites'

    expect(page).to have_content("You have not added any favorites to you list.")
  end
end
