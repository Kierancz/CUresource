class CreateFavoritePosts < ActiveRecord::Migration
  def change
    create_table :favorite_posts do |t|
    	t.integer :course_id
    	t.integer :user_id
    	t.string :integer #?

      t.timestamps
    end
  end
end
