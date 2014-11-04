class AddPolymorphicFavorites < ActiveRecord::Migration
  def change
  	create_table :favorites do |t|
  		t.references :favoritable, polymorphic: true, index: true
  		t.references :user, index: true
  		t.timestamps
  	end
  end
end
