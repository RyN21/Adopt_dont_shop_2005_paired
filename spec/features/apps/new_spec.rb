require 'rails_helper'

RSpec.describe "new application page" do
it "should show a form to choose from favorited pets and enter information" do
    # dummy data

    visit "/favorites"

    click_on "Apply Now"

    expect(current_path).to eq("/apps/new")

    select(@dog.name)
    select(@dog2.name)
    fill_in :name, with: "Name"
    fill_in :address, with: "Address"
    fill_in :city, with: "City"
    fill_in :state, with: "State"
    fill_in :zip, with: "Zip"
    fill_in :phone_number, with: "Phone Number"
    fill_in :description, with: "Description"

    click_button "Submit"

    expect(current_path).to eq("/favorites")
    expect(page).to have_content("Flash Message")

    # within class
    expect(page).to_not have_content(@dog.name)
    expect(page).to_not have_content(@dog2.name)
    
  end
end
