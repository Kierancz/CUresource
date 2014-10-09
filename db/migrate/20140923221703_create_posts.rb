class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
    	t.string :title
    	t.text :description
      t.text :content
    	t.integer :user_id
    	t.integer :postable_id
    	t.string :postable_type

      t.timestamps
    end
  end
end
