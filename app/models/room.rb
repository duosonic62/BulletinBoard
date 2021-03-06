# == Schema Information
#
# Table name: rooms
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  title       :string
#  description :string
#  user_id     :integer
#

class Room < ApplicationRecord
  belongs_to :user
  has_many :messages
  has_many :room_tag_relations
  has_many :tag, through: :room_tag_relations
  paginates_per 10

  validates :title, presence: true, length: {maximum: 50}
  validates :description, presence: true, length: {maximum: 300}
end
