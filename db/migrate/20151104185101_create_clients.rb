class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :instagram_id
      t.timestamps :created_at
      t.timestamps :updated_at 
    end 
  end
end
