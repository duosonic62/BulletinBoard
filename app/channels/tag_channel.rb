class TagChannel < ApplicationCable::Channel
  def subscribed
    stream_from "tag_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end

  def create(data)
    tag = Tag.new(name: data['tag_name'])
    if tag.valid?
      # バリデーションが通った場合のみ登録
      Tag.create!(name: data['tag_name'])
    else
      ActionCable.server.broadcast "tag_channel", error_message: '20文字以下のユニークなタグ名を入力してください'
    end
  end
end
