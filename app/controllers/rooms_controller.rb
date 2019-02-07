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
    else
      # ルームが存在しなければ、エラーメッセージをインデックスでレンダリング
      @room = Room.new()
      flash.now[:alert] = 'Not a valid room id.'
      render 'index'
    end
  end

  # ルーム作成フォームを表示
  def new 
    @room = Room.new(flash[:room])
  end
  
  # ルーム作成
  def create
    room = Room.new(room_params)
    room.user_id = current_user.id
    binding.pry
    if room.save
      redirect_to rooms_show_path(room, id: room.id)
    else
      redirect_to rooms_new_path, flash: {
        room: room,
        alert: room.errors.full_messages
      }
    end
  end


  private
  def room_params
    params.require(:room).permit(:title, :description, tag_ids: [])
  end
  
end
