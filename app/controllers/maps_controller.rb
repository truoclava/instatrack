class MapsController < ApplicationController

def index
  # heathen_url = "https://scontent-lga3-1.xx.fbcdn.net/hphotos-prn2/t31.0-8/10945063_10153025972109462_3692998410985021467_o.jpg"
  # parsed_url = heathen_url.gsub("/","%2F").gsub(":","%3A")

  # num = 120
  
  # @dots = [Map.new(latitude: 40.705333, longitude: -74.0161583)]

  picture_size = 75

  @client = Instagram.client(:access_token => session[:access_token])
  @users = User.get_users(@client)
  
  @hash = Gmaps4rails.build_markers(@users) do |user, marker|
    marker.lat user.media.latitude
    marker.lng user.media.longitude
    marker.picture({
      :url     => "http://i.embed.ly/1/display/resize?height=#{picture_size}&width=#{picture_size}&url=#{user.profile_picture.gsub("/","%2F").gsub(":","%3A")}&key=#{Figaro.env.embedly_key}",
      :width   => "#{picture_size}",
      :height  => "#{picture_size}"
      })
  end
end

end