# require 'rails_helper'
#
# RSpec.describe "Shelter reviews" do
#   it "allows visitors to see a list of reviews for that shelter" do
#     shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
#     shelter_2 = Shelter.create!(name: "New Friends", address: "66 Wall Street", city: "Denver", state: "CO", zip_code: 80204)
#     review_1 = Review.create!(title: "Great shelter!", rating: 4, content: "This shelter has done a great job at pairing me with my new best friend", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2")
#     review_2 = Review.create!(title: "Good shelter!", rating: 5, content: "So happy with the way this shelter has worked", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2")
#
#     visit "/shelters/#{shelter_1.id}"
#
#     expect(page).to have_content("Great shelter!")
#     expect(page).to have_content(review_2.rating)
#     expect(page).to have_content(review_1.content)
#     # expect(page).to have_xpath("//img[contains(@src,'#{dog.image}')]")
#   end
# end
