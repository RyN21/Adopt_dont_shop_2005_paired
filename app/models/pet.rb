class Pet < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :age
  validates_presence_of :sex
  validates_presence_of :image
  belongs_to :shelter
end
