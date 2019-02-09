# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  room_id    :integer
#

require 'rails_helper'

RSpec.describe Message, type: :model do
  context 'messageモデルに正常な値を渡す' do
    let(:user) { create(:alice) }
    let(:room) { create(:alice_bob_room, user: user) }

    let(:hash_message) {[
      content: 'hello Bob!',
      user_id: user.id,
      room_id: room.id
    ]}

    let(:message) { Message.new(content: 'hello Bob!', user_id: user.id, room_id: room.id) }

    it '登録完了後にMessageBroadcastJob.perform_laterを呼び出すこと' do
      # messageをDBに保存した後に、MessageBroadcastJob.perform_laterが呼び出されていることを確認
      expect(MessageBroadcastJob).to receive(:perform_later).once
      Message.create!(hash_message)
    end

    it 'validationにかからないこと' do
      message.valid?
      expect(message).to be_valid
    end
  end

  context 'messageモデルに異常な値を渡す' do
    context 'contentへのvalidationの確認'do
    
      it 'presenceが効くこと' do
        message = Message.new()
        message.valid?
        expect(message.errors.messages[:content]).to include('を入力してください')
      end

      it 'lengthが効くこと' do
        message = Message.new(content: 'a' * 1001 )
        message.valid?
        expect(message.errors.messages[:content]).to include('は1000文字以内で入力してください')

        message = Message.new(content: 'a' * 1000 )
        message.valid?
        expect(message.errors.messages[:content]).not_to include('は1000文字以内で入力してください')
      end
    end
   end
end
