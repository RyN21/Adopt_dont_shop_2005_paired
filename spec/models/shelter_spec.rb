require 'rails_helper'

RSpec.describe Shelter do
  describe 'validations' do
    it { should validate_presence_of :name}
    # it { should validate_presence_of :address }
    # it { should validate_presence_of :city }
    # it { should validate_presence_of :state }
    # it { should validate_presence_of :zip_code }
  end
  describe 'relationships' do
    it { should have_many :pets}
    it { should have_many :reviews}
  end
  describe 'methods' do
    it "#adoptable_pets" do
      shelter_1 = Shelter.create!(name: "Paw Pals", address: "123 Main Street", city: "Denver", state: "CO", zip_code: 80202)
      dog = Pet.create!(name: "Jake", age: 4, sex: "male", status: true, image: "https://epi.azureedge.net/website-images/images/default-album/standard-poodle.jpg?sfvrsn=abed37b_2", shelter_id: shelter_1.id)
      dog2 = Pet.create!(name: "Charley", age: 5, sex: "male", status: false, image: "https://www.pennmedicine.org/news/-/media/images/pr%20news/news/2018/may/summerdog.ashx?h=263&w=400&la=en", shelter_id: shelter_1.id)

      expect(shelter_1.adoptable_pets).to eq([dog])
    end
  end
end
