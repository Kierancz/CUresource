class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
    	t.string :title
    	t.text :description
    	
      t.timestamps
    end
  end
end
