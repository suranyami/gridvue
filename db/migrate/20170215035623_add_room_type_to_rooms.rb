class AddRoomTypeToRooms < ActiveRecord::Migration[5.0]
  def change
    add_reference :rooms, :room_type, index: true, foreign_key: true
  end
end
