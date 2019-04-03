class Colour < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :hex, presence: true, uniqueness: true, format: { with: /#?([A-F0-9]{6}|[A-F0-9]{3})/i, message: "not valid colour" }
  has_and_belongs_to_many :palettes
end
