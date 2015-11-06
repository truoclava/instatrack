class Client < ActiveRecord::Base
  has_many :client_users
  has_many :users, through: :client_users
  # has_one :map

  attr_accessor :username, :profile_picture
end 

