class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :full_name
      t.string :username
      t.float :instagram_id
      t.string :profile_picture
      t.timestamps :created_at
      t.timestamps :updated_at 
    end 
  end
end
