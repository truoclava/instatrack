class MapsController < ApplicationController

  def index
    # heathen_url = "https://scontent-lga3-1.xx.fbcdn.net/hphotos-prn2/t31.0-8/10945063_10153025972109462_3692998410985021467_o.jpg"
    # parsed_url = heathen_url.gsub("/","%2F").gsub(":","%3A")

    # num = 120
    
    @client = Instagram.client(:access_token => session[:access_token])
    @users = current_client.users
    @marker_hash = marker_hash
    @current_client = current_client
    @current_client.username = @client.user.username
    @current_client.profile_picture = @client.user.profile_picture
  end

  def marker_hash
    picture_size = 40
    Gmaps4rails.build_markers(valid_posts) do |post, marker|
      marker.lat post.latitude
      marker.lng post.longitude

      marker.picture({
        :url     => "http://i.embed.ly/1/display/resize?height=#{picture_size}&width=#{picture_size}&url=#{@client.user(post.user.instagram_id)[:profile_picture].gsub("/","%2F").gsub(":","%3A")}&key=#{Figaro.env.embedly_key}",
        :width   => "#{picture_size}",
        :height  => "#{picture_size}"
        })
      marker.infowindow render_to_string(:partial => "/maps/info_window", :locals => { :post => post})
    end 
  end 

  def current_client
    @client = Instagram.client(:access_token => session[:access_token])
    Client.find_or_create_by(instagram_id: @client.user.id)
  end

  def users
    User.get_users(@client, current_client)
  end 

  def valid_posts
    max_time = current_client.updated_at.to_i # only get stuff that is LESS than max time 
    valid_posts = []
    current_client.users.each do |user|
      if !user.posts.nil?
        post = Post.where("user_id = ? AND created_time < ?", user.id, max_time).order(created_time: :desc).limit(1)
        valid_posts << post
      end 
    end
    valid_posts.flatten
  end 

  def update
    @client = Instagram.client(:access_token => session[:access_token])
    old_users = current_client.users
    new_users = @client.user_follows

    # delete association with current client and user if user no longer follows

    old_users_ids = []
    old_users.each do |old_user|
      old_users_ids << old_user.instagram_id
    end 

    new_users.each do |new_user|
      if old_users_ids.include? new_user[:id] # all exist in the new and already exist in old
        @user = User.find_by(instagram_id: new_user[:id])
      else 
        #false we have to create the new_user 
        @user = User.find_or_create_by(instagram_id: new_user[:id])
        ClientUser.create(client_id: current_client.id, user_id: @user.id)
      end 
      @user.get_media(@client)
    end 

    # destroy association

    current_client.updated_at = Time.now 

    redirect_to maps_path
  end 



  # def update
  #   @current_client = Client.find_by(instagram_id: @client.user.id)
  #   old_users = User.all # our table schema

  #   new_users = @client.user_follows # instagram hash 

  #   old_users.each do |old_user|
  #     new_users.each do |new_user| 
  #     # check for everyone in old user that does not exist in new user
  #       if old_user.instagram_id != new_user[:id]
  #         old_user.destroy
  #       end 
  #     end 
  #   end 

  #   new_users.each do |new_user|
  #     @user = User.find_by_or_create(instagram_id: new_user[:id])
  #     @user.update(new_user_params)


  #     Media.find_by_or_create(media_id: client.user_recent_media(new_user[:id], 1)[0][:id])

  #     @user.save
  #   end








  #      # deleted old_user
  # end


  # @client.most_recent_media(@user.instagram_id, 1)[0].


end 