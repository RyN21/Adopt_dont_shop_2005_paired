require 'rails_helper'

RSpec.describe "pets index page" do
  it "allows visitor to see all pets and their information" do
    shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
    shelter_2 = Shelter.create!(name: "New Friends", address: "66 Wall Street", city: "Denver", state: "CO", zip_code: 80204)
    dog = Pet.create!(name: "Jake", age: 4, sex: "male", image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: shelter_1.id, status: true)
    dog2 = Pet.create!(name: "Charley", age: 5, sex: "male", image: "https://www.pennmedicine.org/news/-/media/images/pr%20news/news/2018/may/summerdog.ashx?h=263&w=400&la=en", shelter_id: shelter_2.id, status: true)
    cat = Pet.create!(name: "Finn", age: 2, sex: "male", image: "https://www.lifeinnorway.net/wp-content/uploads/2018/08/male-norwegian-forest-cat.jpg", shelter_id: shelter_1.id, status: true)
    cat2 = Pet.create!(name: "Smudge", age: 6, sex: "female", image: "https://www.aljazeera.com/mritems/imagecache/mbdxxlarge/mritems/Images/2020/4/13/ecab8c7af42a439d9043b0ade6e1f05b_18.jpg", shelter_id: shelter_2.id, status: true)

    visit "/pets"

    expect(page).to have_content(dog.name)
    expect(page).to have_content(dog.age)
    expect(page).to have_content(dog.sex)
    expect(page).to have_xpath("//img[contains(@src,'#{dog.image}')]")
    expect(page).to have_content("Edit #{dog.name}")
    click_on "Edit Jake"
    expect(current_path).to eq("/pets/#{dog.id}/edit")
    visit "/pets"

    expect(page).to have_content(shelter_1.name, count: 2)
    expect(page).to have_content(shelter_2.name, count: 2)

    expect(page).to have_content(dog2.name)
    expect(page).to have_content(dog2.age)
    expect(page).to have_content(dog2.sex)
    expect(page).to have_xpath("//img[contains(@src,'#{dog2.image}')]")
    expect(page).to have_content("Edit #{dog2.name}")
    click_on "Edit Charley"
    expect(current_path).to eq("/pets/#{dog2.id}/edit")
    visit "/pets"

    expect(page).to have_content(cat.name)
    expect(page).to have_content(cat.age)
    expect(page).to have_content(cat.sex)
    expect(page).to have_xpath("//img[contains(@src,'#{cat.image}')]")
    expect(page).to have_content("Edit #{cat.name}")
    click_on "Edit Finn"
    expect(current_path).to eq("/pets/#{cat.id}/edit")
    visit "/pets"

    expect(page).to have_content(cat2.name)
    expect(page).to have_content(cat2.age)
    expect(page).to have_content(cat2.sex)
    expect(page).to have_xpath("//img[contains(@src,'#{cat2.image}')]")
    expect(page).to have_content("Edit #{cat2.name}")
    click_on "Edit Smudge"
    expect(current_path).to eq("/pets/#{cat2.id}/edit")
  end
end
