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
  end
end
