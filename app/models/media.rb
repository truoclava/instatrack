class Media < ActiveRecord::Base
  belongs_to :user

  def initialize
    most_recent_media = @client.user_recent_media(self.user.instagram_id).first
    self.latitude = most_recent_media[:location][:latitude]
    self.longitude = most_recent_media[:location][:longitude]
    self.location_name = most_recent_media[:location][:name]
    self.location_id = most_recent_media[:location][:id]
  end 

end 
