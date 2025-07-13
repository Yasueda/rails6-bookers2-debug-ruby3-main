class Room < ApplicationRecord
  has_many :user_room, dependent: :destroy
  has_many :chats, dependent: :destroy
end
