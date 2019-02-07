# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ApplicationRecord
  has_many :room_tag_relations
  has_many :room, through: :room_tag_relations

  validates :name, presence: true, uniqueness: true, length: {maximum: 10}
  # tagが作成されたら、ジョブのキューに送信するメッセージを追加
  after_create_commit { TagBroadcastJob.perform_later self }
end
