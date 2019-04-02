class Removegbfromcolours < ActiveRecord::Migration[5.2]
  def change
  	remove_column :colours, :G
  	remove_column :colours, :B
  end
end
