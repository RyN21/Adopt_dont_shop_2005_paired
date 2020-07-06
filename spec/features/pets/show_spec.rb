require "rails_helper"

RSpec.describe "pet show page" do
  it "shows the pets name, image, age, sex, description, and status" do
    shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    dog = Pet.create!(name: "Jake", age: 4, sex: "male", description: "He's a dog", status: "Adoptable", shelter_id: shelter_1.id, image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2")

    visit "/pets/#{dog.id}"

    expect(page).to have_content(dog.name)
    expect(page).to have_xpath("//img[contains(@src,'#{dog.image}')]")
    expect(page).to have_content(dog.age)
    expect(page).to have_content(dog.sex)
    expect(page).to have_content(dog.description)
    expect(page).to have_content("Adoption Status: #{dog.status}")
  end
end
