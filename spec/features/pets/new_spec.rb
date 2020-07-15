require 'rails_helper'

RSpec.describe 'new pet page' do
  before :each do
    @shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
  end

  it 'allows visitor to click new pet link and fill in form with new pet details and add new pet' do

    visit "/shelters/#{@shelter_1.id}/pets"
    expect(page).to_not have_content("Karl")
    click_on 'Create Pet'
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets/new")

    fill_in :name, with: "Karl"
    fill_in :age, with: "6"
    fill_in :sex, with: "Male"
    fill_in :description, with: "He is a dog"
    # page.choose('Male')
    fill_in :image, with: "https://image.apost.com/media/articletranslation/2018/08/14/10/41d704e47e7c8d6fdb710e451e98594c_500x1.jpg"

    click_button "Create Pet"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
    expect(page).to have_content("Karl")
    expect(page).to have_content("Adoption Status: Adoptable")
  end

  it 'a flash message appears if not all text fields are filled put' do

    visit "/shelters/#{@shelter_1.id}/pets"

    click_on 'Create Pet'

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets/new")

    fill_in :name, with: "Karl"
    fill_in :age, with: ""
    fill_in :sex, with: ""
    fill_in :description, with: "He's a good dog"
    # page.choose('Male')
    fill_in :image, with: "https://image.apost.com/media/articletranslation/2018/08/14/10/41d704e47e7c8d6fdb710e451e98594c_500x1.jpg"

    click_button "Create Pet"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets/new")
    expect(page).to have_content("Age can't be blank")
    expect(page).to have_content("Sex can't be blank")

  end
end

# User Story 10, Shelter Pet Creation
# - sex ('female' or 'male') make this a checkbox or radio?

# Then a `POST` request is sent to '/shelters/:shelter_id/pets',
# a new pet is created for that shelter,
# that pet has a status of 'adoptable',
