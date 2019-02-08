require 'rails_helper'

RSpec.describe TagChannel, type: :channel do
  let(:user) { create(:alice) }
  let(:room) { create(:alice_bob_room, user: user) }

  before do
    # identifiersでコネクションをイニシャライズ
    stub_connection user_id: user.id
  end

  context '#subscribes' do
    it 'ストリーミングを開始すること' do
      subscribe()
      expect(subscription).to be_confirmed
      expect(subscription).to have_stream_from('tag_channel')
    end
  end

  context '#create' do

    it "正常なリクエストではtagが作成されること" do
      subscribe()
      expect{ perform :create, tag_name: 'ok' }.to change(Tag, :count).by(1)
    end

    it "正常でないリクエストではtagが作成されないこと" do
      subscribe()
      expect(ActionCable).to receive_message_chain(:server, :broadcast).with("tag_channel", error_message: '20文字以下のユニークなタグ名を入力してください')
      # 20文字以上のタグを渡してバリデーションエラーを起こさせる
      expect{ perform :create, tag_name: 'ng'*30 }.to change(Tag, :count).by(0)
    end
  end
end
