class Fixcolumnname < ActiveRecord::Migration[5.2]
  def change
    rename_column :colours_palettes, :color_id, :colour_id
  end
end
