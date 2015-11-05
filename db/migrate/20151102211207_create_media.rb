class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :media_id
      t.string :created_time
      t.float :latitude
      t.float :longitude
      t.string :location_name
      t.integer :location_id
      t.string :image_thumbnail
      t.integer :user_id
      t.timestamps :created_at
      t.timestamps :updated_at 
    end
  end
end
