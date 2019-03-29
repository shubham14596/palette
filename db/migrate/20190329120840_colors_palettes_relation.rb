class ColorsPalettesRelation < ActiveRecord::Migration[5.2]
  def change
    create_table :colors_palettes, id: false do |t|
      t.belongs_to :color, index: true
      t.belongs_to :palette, index: true
    end
  end
end
