class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :username
      t.float :instagram_id
      t.string :profile_picture
    end
  end
end
