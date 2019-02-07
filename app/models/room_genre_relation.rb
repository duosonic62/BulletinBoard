# == Schema Information
#
# Table name: room_genre_relations
#
#  id         :integer          not null, primary key
#  room_id    :integer
#  genre_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RoomGenreRelation < ApplicationRecord
  belongs_to :room
  belongs_to :genre
end
