require 'rails_helper'

RSpec.describe "application show page" do
  it "displays application information including all pets" do
    @shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    @dog = Pet.create!(name: "Jake", age: 4, sex: "male", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: @shelter_1.id)
    @dog2 = Pet.create!(name: "Charley", age: 5, sex: "male", image: "https://www.pennmedicine.org/news/-/media/images/pr%20news/news/2018/may/summerdog.ashx?h=263&w=400&la=en", shelter_id: @shelter_1.id)
    @app = App.create!(name: "John",
      address: "123 Main St", city: "Denver", state: "CO", zip: "80202", phone_number: "123-456-7890",
      description: "I like dogs", pet_ids: ["#{@dog.id}", "#{@dog2.id}"])

    visit "/apps/#{@app.id}"

    expect(page).to have_content(@app.name)
    expect(page).to have_content(@app.address)
    expect(page).to have_content(@app.city)
    expect(page).to have_content(@app.state)
    expect(page).to have_content(@app.zip)
    expect(page).to have_content(@app.phone_number)
    expect(page).to have_content(@app.description)
    expect(page).to have_content(@dog.name)
    expect(page).to have_content(@dog2.name)
  end
end
