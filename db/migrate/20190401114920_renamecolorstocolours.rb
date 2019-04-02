class Renamecolorstocolours < ActiveRecord::Migration[5.2]
  def change
    rename_table :colors, :colours
  end
end
