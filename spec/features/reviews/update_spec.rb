require 'rails_helper'

RSpec.describe "Edit a Shelter Review" do
  before :each do
    @shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    @review_1 = @shelter_1.reviews.create!(title: "TEST!", rating: 4, content: "This shelter has done a great job at pairing me with my new best friend", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2")
    @review_2 = @shelter_1.reviews.create!(title: "Good shelter!", rating: 5, content: "So happy with the way this shelter has worked", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2")

  end
  describe "Creating a new review" do
    it "can edit a shelter review" do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content("TEST!")


      click_on "Edit #{@review_1.title}"

      expect(current_path).to eq("/reviews/#{@review_1.id}/edit")
      # expect(page).to have_content("TEST!")
      # expect(page).to have_content(4)

      fill_in :title, with: "Sweet shelter!"
      fill_in :rating, with: 5
      fill_in :content, with: "Would recommend this shelter to everyone"
      fill_in :image, with: ""

      click_button "Update Review"

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
      expect(page).to have_content("Sweet shelter!")
      expect(page).to have_content(5)
      expect(page).to have_content("Would recommend this shelter to everyone")
    end
  end
  describe "When a user fails to enter fill in a title, rating, or content when editing and tries to submit" do
    it "flashes a message indicating the user need to add addition information" do

      visit "/reviews/#{@review_1.id}/edit"
      fill_in :title, with: "Awesome shelter"
      fill_in :rating, with: nil
      fill_in :content, with: nil
      fill_in :image, with: nil

      click_button "Update Review"

      expect(page).to have_content("Need additional information. Please fill in title, rating, and content to submit review.")
      expect(current_path).to eq("/reviews/#{@review_1.id}/edit")
    end
  end
end
