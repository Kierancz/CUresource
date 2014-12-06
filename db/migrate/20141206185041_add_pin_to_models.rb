class AddPinToModels < ActiveRecord::Migration
  def change
  	add_column :departments, :pin, :boolean
  	add_column :courses, :pin, :boolean
  	add_column :posts, :pin, :boolean
  end
end
