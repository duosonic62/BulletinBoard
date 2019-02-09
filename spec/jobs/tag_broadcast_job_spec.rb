require 'rails_helper'

RSpec.describe TagBroadcastJob, type: :job do
  ActiveJob::Base.queue_adapter = :test

  describe '#perform' do
    it 'Queuにジョブが追加されること' do
      tag = build_stubbed(:java_tag)
      expect { TagBroadcastJob.perform_later(tag) }.to have_enqueued_job(TagBroadcastJob)
    end

    it 'ActionCable.server.broadcastを呼び出していること' do
      tag = create(:java_tag)
      # 呼び出しを確認するモックを作成しておく
      expect(ActionCable).to receive_message_chain(:server, :broadcast)

      # 呼び出す
      perform_enqueued_jobs do
        TagBroadcastJob.perform_later(tag)
      end
    end
  end
end
