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

FactoryBot.define do
  factory :javatag, class: RoomTagRelation do
    association :tag, factory: :java
    association :room, factory: :alice_bob_room
  end

  factory :rubytag, class: RoomTagRelation do
    association :tag, factory: :ruby
    association :room, factory: :alice_bob_room
  end
end
