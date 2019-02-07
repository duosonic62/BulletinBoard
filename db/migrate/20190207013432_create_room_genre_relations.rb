class CreateRoomGenreRelations < ActiveRecord::Migration[5.1]
  def change
    create_table :room_genre_relations do |t|
      t.references :room, foreign_key: true
      t.references :genre, foreign_key: true

      t.timestamps
    end
  end
end
