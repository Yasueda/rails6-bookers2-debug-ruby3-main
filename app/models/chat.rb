class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :message, presence: ture, lenght: {maximum: 140}
end
