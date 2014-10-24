class AddRoleKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :instructor, :boolean
    add_column :users, :rolekey, :string
  end
end
