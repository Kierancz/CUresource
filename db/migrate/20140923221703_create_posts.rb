class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
    	t.string :title
    	t.text :description
      t.text :content
    	t.integer :user_id
    	t.integer :postable_id
    	t.string :postable_type
      t.integer :department_id
      t.integer :course_id

      t.timestamps
    end
  end
end
