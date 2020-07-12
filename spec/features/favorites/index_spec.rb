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

    expect(page).to have_content("You have no favorites in you list.")
  end

  it "can remove all favorites from favorite list" do
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

    click_button "Remove all favorited pets"

    expect(current_path).to eq('/favorites')

    expect(page).to have_content("You have no favorites in you list.")
    expect(page).to have_content("Favorites: 0")

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
  end
  it "has a section for pets with applications" do
    visit "/pets/#{@dog.id}"
    click_button "Add to Favorites"
    visit "/pets/#{@dog2.id}"
    click_button "Add to Favorites"
    expect(page).to have_content("Favorites: 2")

    visit "/favorites"
    click_on "Apply Now"
    expect(current_path).to eq("/apps/new")

    select(@dog.name)
    fill_in :name, with: "Name"
    fill_in :address, with: "Address"
    fill_in :city, with: "City"
    fill_in :state, with: "State"
    fill_in :zip, with: "Zip"
    fill_in :phone_number, with: "Phone Number"
    fill_in :description, with: "Description"

    click_button "Submit"

    expect(page).to have_content("Pending Applications")

    within (".apps") do
      expect(page).to have_content(@dog.name)
    end
  end
end
