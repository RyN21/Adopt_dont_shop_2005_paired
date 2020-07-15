require 'rails_helper'

RSpec.describe "Shelter review creatioin" do
  before :each do
    @shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
  end

  it "can create a new review" do
    visit "/shelters/#{@shelter_1.id}"

    click_on "Add Review"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")

    fill_in :title, with: "Awesome shelter"
    fill_in :rating, with: 4
    fill_in :content, with: "Would recommend this shelter to everyone"
    fill_in :image, with: ""

    click_button "Submit"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    expect(page).to have_content("Awesome shelter")
    expect(page).to have_content("Would recommend this shelter to everyone")
  end

  describe "When a visitor fails to enters a title, rating, or content or enters a wrong rating" do
    it "flashes a message indicating the user need to add addition information" do
      visit "/shelters/#{@shelter_1.id}/reviews/new"

      fill_in :title, with: "Awesome shelter"
      fill_in :rating, with: nil
      fill_in :content, with: nil
      fill_in :image, with: nil

      click_button "Submit"

      expect(page).to have_content("Rating can't be blank")
      expect(page).to have_content("Content can't be blank")
      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")
    end

    # it "flashes a message indicating the user needs to fill out an appropriate rating" do
    #   visit "/shelters/#{@shelter_1.id}/reviews/new"
    #
    #   fill_in :title, with: "Awesome shelter"
    #   fill_in :rating, with: 9
    #   fill_in :content, with: "Awesome shelter."
    #   fill_in :image, with: ""
    #
    #   click_button "Submit"
    #
    #   expect(page).to have_button("Submit")
    # end
  end
end
