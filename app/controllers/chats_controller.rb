class ChatsController < ApplicationController
  before_action :mutual_follow, only: [:show]

  def show
    # 相手ユーザーを取得
    @partner = User.find(params[:id])

    # current_idが登録されているroom_idのリスト
    current_rooms = current_user.user_rooms.pluck(:room_id)

    # 相手ユーザーがcurrent_idが参加しているroom_idの中にいるか
    user_room = UserRoom.find_by(user_id: @partner.id, room_id: current_rooms)

    unless user_room.nil?
      @room = user_room.room
    else
      @room = Room.new
      @room.save

      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @partner.id, room_id: @room.id)
    end

    @chats = @room.chats
    @chat = Chat.new(room_id: @room_id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
  end

  def destroy
    @chat = current_user.chats.find(params[:id])
    @chat.destroy
  end

  def mutual_follow
    partner = User.find(params[:id])

    unless current_user.followed_by?(partner) && partner.followed_by?(current_user)
      redirect_to :back
    end
  end
end
