require "rails_helper"

RSpec.describe Pet, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :age}
    it { should validate_presence_of :sex}
    it { should validate_presence_of :image}
    # it { should validate_presence_of :status}
  end
  describe 'relationships' do
    it { should belong_to :shelter}
    it {should belong_to :shelter}
    it {should have_many :pet_apps}
    it {should have_many(:apps).through(:pet_apps)}
  end
end
