class AddColumnsToDepartment < ActiveRecord::Migration
  def change
  	add_column :departments, :type, :string
  	add_column :posts, :type, :string
  	add_column :users, :bio, :string
  end
end
