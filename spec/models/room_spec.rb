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

require 'rails_helper'

RSpec.describe Room, type: :model do

  let(:user) { create(:alice) }

  context 'roomモデルに正常な値を渡す' do
    before do
      create(:alice_bob_room, user: user)
    end

    # alice_bob_roomと被っていない正常な情報を準備
    let(:room) { Room.new(title: 'test room', description: 'test description',user: user) }

    it 'validationにかからないこと' do
      room.valid?
      expect(room).to be_valid
    end
   end

   context 'roomモデルに異常な値を渡す' do
    it 'presenceが効くこと' do
      room = Room.new()
      room.valid?
      expect(room.errors.messages[:title]).to include('を入力してください')
      expect(room.errors.messages[:description]).to include('を入力してください')
    end

    it 'lengthが効くこと' do
      room = Room.new(title: 'a' * 51 , description: 'a' * 301)
      room.valid?
      expect(room.errors.messages[:title]).to include('は50文字以内で入力してください')
      expect(room.errors.messages[:description]).to include('は300文字以内で入力してください')

      room = Room.new(title: 'a' * 50 , description: 'a' * 300)
      room.valid?
      expect(room.errors.messages[:title]).not_to include('は50文字以内で入力してください')
      expect(room.errors.messages[:description]).not_to include('は300文字以内で入力してください')
    end
   end
end
