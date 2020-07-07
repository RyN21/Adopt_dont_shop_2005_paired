class Review < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :rating
  validates_presence_of :content
  validates_presence_of :image
  belongs_to :shelter
end
