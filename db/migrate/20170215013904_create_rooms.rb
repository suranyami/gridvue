class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.belongs_to :hotel, foreign_key: true
    end
  end
end
