class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
    	t.string :title
    	t.text :description
    	t.integer :user_id
    	t.integer :postable_id
    	t.string :postable_type

      t.timestamps
    end
    add_index :posts, [:course_id, :user_id, :department_id]
  end
end
