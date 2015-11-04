# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  full_name       :string
#  username        :string
#  instagram_id    :float
#  profile_picture :string
#

class User < ActiveRecord::Base
  has_many :client_users
  has_many :clients, through: :client_users
  has_one :media, dependent: :destroy


  def self.get_users(client, current_client)
    client.user_follows.each do |user|
      user_attributes = {
      "full_name" => user[:full_name],
      "username" => user[:username],
      "instagram_id" => user[:id],
      "profile_picture" => user[:profile_picture]
      }
      user = User.create(user_attributes)
      ClientUser.create({"client_id" => current_client.id,"user_id" => user.id})

      user.get_media(client, user)
    end 
  end 

  def get_media(client, user)
    most_recent_media = client.user_recent_media(user.instagram_id.to_i, 1)[0]
    if most_recent_media && most_recent_media[:location]
      location = most_recent_media[:location]
      image_thumbnail = most_recent_media[:images][:thumbnail][:url]
      user.create_media(latitude: location[:latitude], longitude: location[:longitude], location_name: location[:name], location_id: location[:id], image_thumbnail: image_thumbnail)
    end 
  end 


end 

