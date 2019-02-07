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

  
  
end
