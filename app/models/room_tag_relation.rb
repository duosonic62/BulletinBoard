# == Schema Information
#
# Table name: room_tag_relations
#
#  id         :integer          not null, primary key
#  room_id    :integer
#  tag_id     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RoomTagRelation < ApplicationRecord
  belongs_to :room
  belongs_to :tag
end
