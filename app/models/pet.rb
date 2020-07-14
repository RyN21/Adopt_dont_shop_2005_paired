class Pet < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :age
  validates_presence_of :sex
  validates_presence_of :image

  belongs_to :shelter
  has_many :pet_apps
  has_many :apps, through: :pet_apps
end
