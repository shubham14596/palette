class CreateColors < ActiveRecord::Migration[5.2]
  def change
    create_table :colors do |t|
      t.string :name
      t.integer :status
      t.integer :R
      t.integer :G
      t.integer :B

      t.timestamps
    end
  end
end
