require 'rails_helper'

RSpec.describe 'Create a new Shelter' do
  describe 'when visting the shelters index page' do
    it 'can follow a link to create a new shelter' do
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
  end
end
