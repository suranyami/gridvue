class CreateRoomType < ActiveRecord::Migration[5.0]
  def change
    create_table :room_types do |t|
      t.string :name
    end
  end
end
