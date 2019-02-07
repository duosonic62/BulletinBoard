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

require 'rails_helper'

RSpec.describe RoomGenreRelation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
