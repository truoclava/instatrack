class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.float :latitude
      t.float :longitude
      t.string :location_name
      t.integer :location_id
      t.integer :user_id
    end
  end
end
