class Shelter < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip_code

  has_many :pets
  has_many :reviews

  def adoptable_pets
     pets.find_all do |pet|
      pet.status == true
    end
  end

  def pending_pets
    pets.find_all do |pet|
      pet.status == false
    end
  end

  def pet_count
    pets.count
  end

  def average_rating
    reviews.all.average(:rating)
  end

  def number_of_applications_on_file
    apps = []
    pets.each do |pet|
      apps << pet.apps
    end
    apps.flatten.count
  end
end
