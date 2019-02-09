require 'rails_helper'

RSpec.describe MessageBroadcastJob, type: :job do
  ActiveJob::Base.queue_adapter = :test

  describe '#perform' do
    let(:user) { create(:alice) }
    let(:room) { create(:alice_bob_room, user: user) }

    it 'Queuにジョブが追加されること' do
      message = build_stubbed(:message_to_bob)
      expect { MessageBroadcastJob.perform_later(message) }.to have_enqueued_job(MessageBroadcastJob)
    end

    it 'ActionCable.server.broadcastを呼び出していること' do
      message = create(:message_to_bob,  user: user, room: room)
      # 呼び出しを確認するモックを作成しておく
      expect(ActionCable).to receive_message_chain(:server, :broadcast)

      # 呼び出す
      perform_enqueued_jobs do
        MessageBroadcastJob.perform_later(message)
      end
    end
  end
end
