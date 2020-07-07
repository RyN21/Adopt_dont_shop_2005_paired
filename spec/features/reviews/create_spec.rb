require 'rails_helper'

RSpec.describe "Shelter review creatioin" do
  it "can create a new review" do
    shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)

    visit "/shelters/#{shelter_1.id}"

    click_on "Add Review"

    expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")

    fill_in :title, with: "Awesome shelter"
    fill_in :rating, with: 4
    fill_in :content, with: "Would recommend this shelter to everyone"
    fill_in :image, with: ""

    click_button "Submit"

    expect(current_path).to eq("/shelters/#{shelter_1.id}")
    expect(page).to have_content("Awesome shelter")
    expect(page).to have_content("Would recommend this shelter to everyone")
  end
end





# require 'rails_helper'
#
# RSpec.describe "Shelter review creation" do
#   it "can create a new review" do
#     shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
#
#     visit "/shelters/#{shelter_1.id}"
#     click_on "Add Review"
#
#     expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")
#
#     fill_in :title, with: "Awesome shelter"
#     fill_in :rating, with: 4
#     fill_in :content, with: "Would recommend this shelter to everyone"
#     fill_in :image, with: ""
#
#     click_button "Add"
#
#     expect(current_path).to eq("/shelters/#{shelter_1.id}")
#
#     new_review = shelter_1.reviews.last
#     expect(page).to have_content(new_review.title)
#     expect(page).to have_content(new_review.rating)
#     expect(page).to have_content(new_review.content)
#   end
# end
