class Renamecolorspalettestocolourspalettes < ActiveRecord::Migration[5.2]
  def change
    rename_table :colors_palettes, :colours_palettes
  end
end
