# == Schema Information
#
# Table name: media
#
#  id            :integer          not null, primary key
#  latitude      :float
#  longitude     :float
#  location_name :string
#  location_id   :integer
#  user_id       :integer
#

class Media < ActiveRecord::Base
  belongs_to :user # foreign key, user_id

end 
