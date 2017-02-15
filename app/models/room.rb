class Room < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :hotel
  belongs_to :room_type
end
