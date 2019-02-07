class Genre < ApplicationRecord
  has_many :room_genre_relations
  has_many :room, through: :room_genre_relations
end
