# == Schema Information
#
# Table name: rooms
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  title       :string
#  description :string
#

class Room < ApplicationRecord
  belongs_to :user
  has_many :messages
  has_many :room_genre_relations
  has_many :genre, through: :room_genre_relations

end
