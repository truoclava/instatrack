class CreateClientUsers < ActiveRecord::Migration
  def change
    create_table :client_users do |t|
      t.integer :client_id
      t.integer :user_id
      t.timestamps :created_at
      t.timestamps :updated_at 
      # t.index [:client_id, :user_id]
      # t.index [:user_id, :client_id]
    end
  end
end
