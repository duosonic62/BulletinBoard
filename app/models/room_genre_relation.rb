class RoomGenreRelation < ApplicationRecord
  belongs_to :room
  belongs_to :genre
end
