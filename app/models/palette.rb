class Palette < ApplicationRecord
  has_and_belongs_to_many :colours
  @@colors = []
  def self.initialize_array
    @@colors = []
  end

  def self.colors
    @@colors
  end
end
