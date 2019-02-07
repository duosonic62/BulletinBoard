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
  factory :room_genre_relation do
    room { nil }
    genre { nil }
  end
end
