require 'rails_helper'

RSpec.describe "Delete Shelter Review" do
  it "can delete a review from the shelter reivews section" do
    shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    review_1 = shelter_1.reviews.create!(title: "TEST!", rating: 4, content: "This shelter has done a great job at pairing me with my new best friend", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2")

    visit "/shelters/#{shelter_1.id}"

    click_button "Delete Review"

    expect(current_path).to eq("/shelters/#{shelter_1.id}")
    expect(page).to_not have_content('TEST!')
  end
end
