# require 'rails_helper'
#
# RSpec.describe "Edit a Shelter Review" do
#   it "can edit a shelter review" do
#     shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
#     review_1 = shelter_1.reviews.create!(title: "Great shelter!", rating: 4, content: "This shelter has done a great job at pairing me with my new best friend", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2")
#     review_2 = shelter_1.reviews.create!(title: "Good shelter!", rating: 5, content: "So happy with the way this shelter has worked", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2")
#     visit "/shelters/#{shelter_1.id}"
#
#     click_on "Edit #{review_1.title}"
#
#     visit "/reviews/#{review_1.id}/edit"
#
#     expect(page).to have_content("Great shelter!")
#     expect(page).to have_content(4)
#
#     fill_in :title, with: "Sweet shelter!"
#     fill_in :rating, with: 5
#     fill_in :content, with: "Would recommend this shelter to everyone"
#     fill_in :image, with: ""
#
#     click_button "Submit"
#
#     expect(current_path).to eq("/shelters/#{shelter_1.id}")
#
#     expect(find_field(:title).value).to eq("Sweet shelter!")
#     expect(find_field(:rating).value).to eq(5)
#   end
#
# end
