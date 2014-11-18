class AddColumnsToDepartment < ActiveRecord::Migration
  def change
  	add_column :departments, :college, :string
  	add_column :departments, :campus, :string
  	add_column :departments, :acro, :string
  	rename_column :departments, :name, :subject

  	add_column :courses, :credits, :integer
  	add_column :courses, :subject, :string
  end
end
