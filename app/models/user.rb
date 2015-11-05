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


#@client.user_recent_media(user.instagram_id, 1)[0][:id] 

class User < ActiveRecord::Base
  has_many :client_users
  has_many :clients, through: :client_users
  has_one :media, dependent: :destroy

  attr_accessor :username, :profile_picture

  def self.get_users(client, current_client)
    client.user_follows.each do |user|
      @user = User.create({"instagram_id" => user[:id]})
      @user.username = user[:username]
      @user.profile_picture = user[:profile_picture]

      ClientUser.create({"client_id" => current_client.id,"user_id" => @user.id})
      @user.get_media(client)
    end 
  end 


  def get_media(client) # show media based on LAST UPDATE of client
    @current_client = Client.find_by(instagram_id: client.user.id)
    max_timestamp =  @current_client.updated_at.to_i
    last_media = client.user_recent_media(self.instagram_id, 1, {max_timestamp: max_timestamp})[0]
    if last_media && last_media[:location]
      media_id = last_media[:id]
      created_time = last_media[:created_time]
      location = last_media[:location]
      image_thumbnail = last_media[:images][:thumbnail][:url]
      self.create_media(media_id: media_id, created_time: created_time, latitude: location[:latitude], longitude: location[:longitude], location_name: location[:name], location_id: location[:id], image_thumbnail: image_thumbnail)
    end 
    # media = client.media_item(user.media.media_id)
    # created_time = media[:created_time]
    # location = media[:location]
    # image_thumbnail = media[:images][:thumbnail][:url]
    # what do we REALLY need in the database
  end 

 

end 

#@client.user_recent_media(user_id, {"max_timestamp" => a, "count" => 1})[0][:images][:thumbnail][:url]
