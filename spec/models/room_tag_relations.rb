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

# 中間テーブルへのテストは必要か？
RSpec.describe room_tag_relations, type: :model do
  
end