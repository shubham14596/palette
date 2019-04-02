class Colour < ApplicationRecord
  has_and_belongs_to_many :palettes
end
