require 'rails_helper'

RSpec.describe Review do
  describe 'validations' do
    it { should validate_presence_of :title}
    it { should validate_presence_of :rating}
    it { should validate_presence_of :content}
  end
end
