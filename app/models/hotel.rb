class Hotel < ActiveRecord::Base
  validates :name, presence: true
  has_many :rooms, dependent: :destroy
  has_many :room_rates, dependent: :destroy
end
