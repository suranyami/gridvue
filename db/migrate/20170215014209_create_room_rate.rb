class CreateRoomRate < ActiveRecord::Migration[5.0]
  def change
    create_table :room_rates do |t|
      t.integer :price
      t.datetime :from_date, index: true
      t.datetime :to_date, index: true
      t.belongs_to :room_type, foreign_key: true
      t.belongs_to :hotel, foreign_key: true
    end
  end
end
