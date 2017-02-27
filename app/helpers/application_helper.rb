module ApplicationHelper

  def num_rooms(hotel)
    hotel.rooms.count
  end
end
