require 'rails_helper'

RSpec.describe 'Create a new Shelter' do
  it 'can follow a link to create a new shelter and create a shelter' do
    visit '/shelters'

    expect(page).to_not have_content('Paw Pals')

    click_on 'New Shelter'

    expect(current_path).to eq('/shelters/new')

    fill_in :name, with: "Paw Pals"
    fill_in :address, with: "123 Main Street"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"
    fill_in :zip_code, with: "80202"

    click_button "Create Shelter"

    expect(current_path).to eq("/shelters")
    expect(page).to have_content("Paw Pals")
  end

  it 'if not all information is filled out, a message appears' do
    visit '/shelters/new'

    fill_in :name, with: "Paw Pals"
    fill_in :address, with: ""
    fill_in :city, with: "Denver"
    fill_in :state, with: ""
    fill_in :zip_code, with: "80202"

    click_button "Create Shelter"


    expect(current_path).to eq("/shelters/new")
    expect(page).to have_content("Address can't be blank")
    expect(page).to have_content("State can't be blank")
  end
end
