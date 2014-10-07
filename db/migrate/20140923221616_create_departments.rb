class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
    	t.string :name
    	t.string :title
    	t.text :description
    	t.text :banner
    	t.text :info
    	
      t.timestamps
    end
  end
end
