class RenameGenreToTag < ActiveRecord::Migration[5.1]
  def change
    rename_table :genres, :tags
    rename_table :room_genre_relations, :room_tag_relations
    rename_column :room_tag_relations, :genre_id, :tag_id
  end
end
