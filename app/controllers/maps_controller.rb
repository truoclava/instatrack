class MapsController < ApplicationController

  def index
    # heathen_url = "https://scontent-lga3-1.xx.fbcdn.net/hphotos-prn2/t31.0-8/10945063_10153025972109462_3692998410985021467_o.jpg"
    # parsed_url = heathen_url.gsub("/","%2F").gsub(":","%3A")

    # num = 120
    
    # @dots = [Map.new(latitude: 40.705333, longitude: -74.0161583)]
    @client = Instagram.client(:access_token => session[:access_token])
    @current_client = Client.find_by(instagram_id: @client.user.id)

    picture_size = 40

    @hash = Gmaps4rails.build_markers(valid_users) do |user, marker|
      if user.valid? 
      # user.media.image_thumbnail
        marker.json({ id: user.instagram_id })
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

  def users

    @client = Instagram.client(:access_token => session[:access_token])

    if Client.find_by(instagram_id: @client.user.id)
      @current_client = Client.find_by(instagram_id: @client.user.id)
      @current_client.users
    else # Client does NOT exist yet
      @current_client = Client.create(instagram_id: @client.user.id)
      @current_client.full_name = @client.user.full_name
      @current_client.username = @client.user.username
      @current_client.profile_picture = @client.user.profile_picture
      @current_client.save
      User.get_users(@client, @current_client)
      binding.pry
    end 
  end 

  def valid_users
    users.select do |user|
      user.media 
    end 
  end 
end 