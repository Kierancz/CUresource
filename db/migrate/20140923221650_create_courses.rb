class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
    	t.string :title
    	t.text :description
    	t.string :department_name
    	t.integer :number
      t.text :banner
      t.text :info
      t.integer :department_id
    	
      t.timestamps
    end
  end
end
