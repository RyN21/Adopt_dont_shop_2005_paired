require 'rails_helper'

RSpec.describe "pet applications index page" do
  it "displays a list of all the names of applicants for this pet" do
    @shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    @dog = Pet.create!(name: "Jake", age: 4, sex: "male", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: @shelter_1.id, status: true)
    @dog2 = Pet.create!(name: "Charley", age: 5, sex: "male", image: "https://www.pennmedicine.org/news/-/media/images/pr%20news/news/2018/may/summerdog.ashx?h=263&w=400&la=en", shelter_id: @shelter_1.id, status: true)
    @app = App.create!(name: "John",
      address: "123 Main St", city: "Denver", state: "CO", zip: "80202", phone_number: "123-456-7890",
      description: "I like dogs", pet_ids: ["#{@dog.id}", "#{@dog2.id}"])
    @app2 = App.create!(name: "Karl",
      address: "12 Dog Ave", city: "Denver", state: "CO", zip: "80202", phone_number: "098-765-4321",
      description: "I, too, like dogs", pet_ids: ["#{@dog.id}"])

    visit "/pets/#{@dog.id}"
    click_on "Applications"

    expect(current_path).to eq("/pets/#{@dog.id}/apps")

    expect(page).to have_content(@app.name)
    expect(page).to have_content(@app2.name)

    expect(page).to have_link(@app.name, href: "/apps/#{@app.id}")
    expect(page).to have_link(@app2.name, href: "/apps/#{@app2.id}")
  end
  it "displays a message for no applications" do
    @shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    @dog = Pet.create!(name: "Jake", age: 4, sex: "male", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: @shelter_1.id, status: true)
    @dog2 = Pet.create!(name: "Charley", age: 5, sex: "male", image: "https://www.pennmedicine.org/news/-/media/images/pr%20news/news/2018/may/summerdog.ashx?h=263&w=400&la=en", shelter_id: @shelter_1.id, status: true)
    @app = App.create!(name: "John",
      address: "123 Main St", city: "Denver", state: "CO", zip: "80202", phone_number: "123-456-7890",
      description: "I like dogs", pet_ids: ["#{@dog.id}"])

    visit "/pets/#{@dog2.id}"
    click_on "Applications"

    expect(current_path).to eq("/pets/#{@dog2.id}/apps")

    expect(page).to_not have_content(@app.name)
    expect(page).to have_content("No Applications for #{@dog2.name}")

  end
end
