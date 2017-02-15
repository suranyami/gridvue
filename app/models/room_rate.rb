class RoomRate < ActiveRecord::Base
  validates :from_date, presence: true
  validates :to_date, presence: true

  belongs_to :hotel
  belongs_to :room_type
end
