require 'rails_helper'

RSpec.describe Favorite do
  before(:each) do
    @favorite = Favorite.new({'1' => 1, '2' => 1})
  end

  describe "methods" do
    it "#total_count" do
      expect(@favorite.total_count).to eq(2)
    end
    it "#add_pet" do
      @favorite.add_pet(3)
      @favorite.add_pet(4)

      expect(@favorite.favorite_pets).to eq({'1' => 1, '2' => 1, '3' => 1, '4' => 1})
    end
    it "#count_of" do
      favorite = Favorite .new({})

      expect(favorite.count_of(5)).to eq(0)
    end
  end
end
