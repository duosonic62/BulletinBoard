class RemoveFromRooms < ActiveRecord::Migration[5.1]
  def change
    remove_column :rooms, :room_id, :string
    add_column :rooms, :title, :string
    add_column :rooms, :description, :string
  end
end
