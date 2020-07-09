require 'rails_helper'

RSpec.describe "Shelter reviews" do
  it "allows visitors to see a list of reviews for that shelter" do
    shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    review_1 = shelter_1.reviews.create!(title: "Great shelter!", rating: 4, content: "This shelter has done a great job at pairing me with my new best friend", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: shelter_1.id)
    review_2 = shelter_1.reviews.create!(title: "Good shelter!", rating: 5, content: "So happy with the way this shelter has worked", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: shelter_1.id)

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content("Great shelter!")
    expect(page).to have_content(review_2.rating)
    expect(page).to have_content(review_1.content)
    # expect(page).to have_xpath("//img[contains(@src,'#{review_1.image}')]")
  end
end
