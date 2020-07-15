require 'rails_helper'

RSpec.describe "application show page" do
  before :each do
    @shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    @dog = Pet.create!(name: "Jake", age: 4, sex: "male", description: "A Dog", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: @shelter_1.id, status: true)
    @dog2 = Pet.create!(name: "Charley", age: 5, sex: "male", description: "Also a Dog", image: "https://www.pennmedicine.org/news/-/media/images/pr%20news/news/2018/may/summerdog.ashx?h=263&w=400&la=en", shelter_id: @shelter_1.id, status: true)
    @app = App.create!(name: "John",
      address: "123 Main St", city: "Denver", state: "CO", zip: "80202", phone_number: "123-456-7890",
      description: "I like dogs", pet_ids: ["#{@dog.id}", "#{@dog2.id}"])
  end

  it "displays application information including all pets" do

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
  it "has a link to approve the application for each pet" do
    @app2 = App.create!(name: "Karl",
      address: "12 Dog Ave", city: "Denver", state: "CO", zip: "80202", phone_number: "098-765-4321",
      description: "I, too, like dogs", pet_ids: ["#{@dog.id}"])

    visit "/apps/#{@app.id}"

    expect(page).to have_button("Approve Application for #{@dog.name}")
    expect(page).to have_button("Approve Application for #{@dog2.name}")


    click_on "Approve Application for #{@dog.name}"

    expect(current_path).to eq("/pets/#{@dog.id}")

    expect(page).to have_content("Adoption Status: Adoption Pending")
    expect(page).to have_content("On Hold for #{@app.name}")
  end
  it "can approve multiple pets for the same application" do
    @app2 = App.create!(name: "Karl",
      address: "12 Dog Ave", city: "Denver", state: "CO", zip: "80202", phone_number: "098-765-4321",
      description: "I, too, like dogs", pet_ids: ["#{@dog.id}"])

    visit "/apps/#{@app.id}"

    expect(page).to have_button("Approve Application for #{@dog.name}")
    expect(page).to have_button("Approve Application for #{@dog2.name}")

    click_on "Approve Application for #{@dog.name}"

    expect(current_path).to eq("/pets/#{@dog.id}")

    expect(page).to have_content("Adoption Status: Adoption Pending")
    expect(page).to have_content("On Hold for #{@app.name}")

    visit "/apps/#{@app.id}"

    click_on "Approve Application for #{@dog2.name}"

    expect(current_path).to eq("/pets/#{@dog2.id}")

    expect(page).to have_content("Adoption Status: Adoption Pending")
    expect(page).to have_content("On Hold for #{@app.name}")
  end
  it "cannot approve multiple applications for the same pet" do
    @app2 = App.create!(name: "Karl",
      address: "12 Dog Ave", city: "Denver", state: "CO", zip: "80202", phone_number: "098-765-4321",
      description: "I, too, like dogs", pet_ids: ["#{@dog.id}"])

    visit "/apps/#{@app.id}"

    click_on "Approve Application for #{@dog.name}"

    visit "/apps/#{@app2.id}"

    expect(page).to_not have_button("Approve Application for #{@dog.name}")

  end
end
