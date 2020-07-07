require 'rails_helper'

RSpec.describe "Shelter review creation" do
  it "can create a new review" do
    shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    review_1 = Review.create!(title: "Great shelter!", rating: 4, content: "This shelter has done a great job at pairing me with my new best friend", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: shelter_1.id)
    review_2 = Review.create!(title: "Good shelter!", rating: 5, content: "So happy with the way this shelter has worked", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: shelter_1.id)

    visit "/shelters/#{shelter_1.id}"

    click_on "Add Review"

    expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")

    fill_in :title, with: "Awesome shelter"
    fill_in :rating, with: 4
    fill_in :content, with: "Would recommend this shelter to everyone"
    fill_in :image, with: ""

    click_button "Add"

    expect(current_path).to eq("/shelters/#{shelter_1.id}")

    new_review = Review.last

    expect(page).to have_content(new_review.title)
    expect(page).to have_content(new_review.rating)
    expect(page).to have_content(new_review.content)
  end
end
