require 'rails_helper'

RSpec.describe "When visiting a shelter show page" do
  before :each do
    @shelter_1 = Shelter.create(name: "Hope", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    @review_1 = @shelter_1.reviews.create!(title: "Great shelter!", rating: 4, content: "This shelter has done a great job at pairing me with my new best friend", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: @shelter_1.id)
    @review_2 = @shelter_1.reviews.create!(title: "Good shelter!", rating: 5, content: "So happy with the way this shelter has worked", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: @shelter_1.id)

  end

  it "can destroy the shelter" do

    visit "/shelters"

    expect(page).to have_content(@shelter_1.name)

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_content(@shelter_1.name)

    click_button "Delete Shelter"

    expect(current_path).to eq("/shelters")
    expect(page).to_not have_content(@shelter_1.name)
  end

  it "deletes all the reviews associated with that shelter when shelter is deleted" do

    visit "/shelters/#{@shelter_1.id}"

    click_button "Delete Shelter"

    expect(current_path).to eq("/shelters")
    expect(page).to_not have_content(@shelter_1.name)
    expect(page).to_not have_content(@review_1.title)
    expect(page).to_not have_content(@review_2.title)
  end
end


# [ ] done
#
# User Story 28, Deleting Shelters Deletes its Reviews
#
# As a visitor
# When I delete a shelter
# All reviews associated with that shelter are also deleted
