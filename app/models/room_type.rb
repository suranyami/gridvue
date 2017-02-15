class RoomType < ActiveRecord::Base
  has_many :rooms, dependent: :destroy
  has_many :room_rates, dependent: :destroy
end
