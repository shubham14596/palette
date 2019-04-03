class Palette < ApplicationRecord
  has_and_belongs_to_many :colours
  @colors = []
  def initialize_array
    @colors = []
  end

  def colors
    @colors
  end
end
