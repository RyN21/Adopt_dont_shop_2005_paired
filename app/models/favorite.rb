class Favorite
  attr_reader :favorite_pets

  def initialize(initial_pets)
    @favorite_pets = initial_pets || Hash.new(0)
  end

  def total_count
    @favorite_pets.values.sum
  end

  def add_pet(id)
    @favorite_pets[id.to_s] = 1
  end

  def count_of(id)
    @favorite_pets[id.to_s].to_i
  end
end
