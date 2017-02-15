task sample: ['sample:destroy', 'sample:hotels', 'sample:room_types', 'sample:rooms', 'sample:room_rates']
namespace :sample do
  task destroy: :environment do
    Room.destroy_all
    RoomType.destroy_all
    RoomRate.destroy_all
    Hotel.destroy_all
  end

  desc 'create sample room types'
  task room_types: :environment do
    10.times do
      room_type = FactoryGirl.create(:room_type)
      puts "RoomType '#{room_type.name}'"
    end
  end

  desc 'create sample rooms'
  task rooms: :environment do
    1000.times do
      hotel = Hotel.all.sample
      room_type = RoomType.all.sample
      room = FactoryGirl.create(:room, hotel: hotel, room_type: room_type)
      puts "Room '#{room.name}' in '#{hotel.name}' of type '#{room_type.name}'"
    end
  end

  desc 'create sample room rates for different times of the year for different rooms'
  task room_rates: :environment do
    100.times do
      hotel = Hotel.all.sample
      room_type = RoomType.all.sample
      room_rate = FactoryGirl.create(:room_rate, hotel: hotel, room_type: room_type)
      puts "RoomRate $#{room_rate.price} in '#{hotel.name}' of type '#{room_type.name}'"
    end
  end

  desc 'create sample hotels'
  task hotels: :environment do
    10.times do
      hotel = FactoryGirl.create(:hotel)
      puts "Hotel '#{hotel.name}'"
    end
  end
end
