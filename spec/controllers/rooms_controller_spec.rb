require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  let(:message) { create(:message_to_bob, user: alice, room: room) }
  let(:alice) { create(:alice) }
  let(:room) { create(:alice_bob_room, user: alice) }

  describe 'GET #index' do
    before do
      login_user alice
      get :index
    end

    it 'レスポンスコードが200であること' do
      expect(response).to have_http_status(:ok)
    end

    it 'indexテンプレートをレンダリングすること' do
      expect(response).to render_template :index
    end

    it 'roomの一覧が渡されれること' do
      expect(assigns(:rooms)).to eq Room.page(0).order('updated_at DESC')
    end
  end

  describe 'Get #new' do
    context 'room作成フォームを表示' do
      before do
        login_user alice
        get :new
      end

      it 'レスポンスコードが200であること' do
        expect(response).to have_http_status(:ok)
      end

      it 'newテンプレートをレンダリングすること' do
        expect(response).to render_template :new
      end

      it '空のroomオブジェクトが渡されれること' do
        expect(assigns(:room)).to be_a_new Room
      end

      it 'flashに値がある場合はその値のroomオブジェクトが渡されれること' do
        flash_hash = ActionDispatch::Flash::FlashHash.new
        flash_hash[:room] = room.attributes
        session['flash'] = flash_hash.to_session_value
        get :new
        expect(assigns(:room)).to eq room
      end
    end
  end

  describe 'Post #create' do
    context '正常な値が渡された場合' do
      let(:params) { { room: { title: 'test title', description: 'test description' } } }

      before do
        login_user alice
      end

      it 'showにリダイレクトされること' do
        post(:create, params: params)
        # 登録したroomを取得
        current_room = Room.order('updated_at DESC').first
        expect(response).to redirect_to rooms_show_path(current_room, id: current_room.id)
      end

      it 'roomが一つ増えていること' do
        expect{ post :create, params: params }.to change(Room, :count).by(1)
      end
    end

    context '異常な値が渡された場合' do
      let(:params) { { room: { title: 'a' * 51 } } }
 
      before do
        login_user alice
      end

      it 'newにリダイレクトされること' do
        post(:create, params: params)
        # 登録したroomを取得
        expect(response).to redirect_to rooms_new_path
      end

      it 'flashにroomが含まれていること' do
        post(:create, params: params)
        flash_room = Room.new(params[:room])
        flash_room.user_id = alice.id
        expect(flash[:room].attributes).to eq flash_room.attributes
      end

      it 'flashにエラーメッセージが含まれていること' do
        post(:create, params: params)
        expect(flash[:error_messages]).to include '掲示板説明を入力してください'
        expect(flash[:error_messages]).to include 'タイトルは50文字以内で入力してください'
      end
    end

  end

  describe 'Post #show' do
    context 'リクエストパラメータのroom_idが存在した場合' do
      let(:params) { {  id: room[:id]} }
  

      before do
        params
        message
        login_user alice
      end

      it 'レスポンスコードが200であること' do
        get(:show, params: params)
        expect(response).to have_http_status(:ok)
      end

      it 'showテンプレートをレンダリングすること' do
        expect(get :show, params: params).to render_template :show
      end

      it 'roomとmessageが取得できること' do
        post(:show, params: params)
        expect(assigns(:messages)).to eq [message]
        expect(assigns(:room)).to eq room
      end
    end

    context 'リクエストパラメータのroom_idが存在しなかった場合' do
      let(:params) { {  id: room[:id]+1 } }
       before do
        login_user alice
        get(:show, params: params)
       end

       it 'レスポンスコードが200であること' do
        expect(response).to have_http_status(:ok)
      end

      it 'indexテンプレートをレンダリングすること' do
        expect(response).to render_template :index
      end

      it 'room一覧のオブジェクトが渡されれること' do
        expect(assigns(:rooms)).to eq Room.page(0).order('updated_at DESC')
      end

      it 'flashにルームIDが間違っているというメッセージが含まれていること' do
        expect(flash[:alert]).to eq('掲示板番号が不正です')
      end
    end

  end
end
