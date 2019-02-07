require "securerandom"

class RoomsController < ApplicationController
  before_action :sign_in_required

  # ルーム一覧を表示
  def index
    @rooms = Room.page(params[:page])
  end
  

  # ルームを表示
  def show
    # ルームが存在するか確認
    if Room.exists?(params[:id]) 
      @room = Room.find(params[:id])
      @messages = @room.messages
      binding.pry
    else
      # ルームが存在しなければ、エラーメッセージをインデックスでレンダリング
      @room = Room.new()
      flash.now[:alert] = 'Not a valid room id.'
      render 'index'
    end
  end

  def new
    # ランダムな8~11文字程度のルームIDを割り振る
    random_room_id = SecureRandom.urlsafe_base64(8)

    # もしルームIDが被ったら新たにユニークなルームIDを発行する
    while Room.exists?(room_id:random_room_id) do
      random_room_id = SecureRandom.urlsafe_base64(8)
    end

    # ルームIDを発行する
    @room = Room.new(room_id: random_room_id)

    if @room.save
      # indexをレンダリング(flashで新規に作成されたIDを渡す)
      flash.now[:created_room_id] = @room.room_id
      render 'index'
    else
      # エラーが発生した際はエラーメッセージをインデックスでレンダリング
      flash.now[:alert] = "Room ID can't create. Try again."
      render 'index'
    end
  end
  
end
