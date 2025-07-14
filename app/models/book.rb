class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :show_counts, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  scope :populer_last, -> (time) {
    sort { |a, b| b.favorites.where('created_at >= ?', time).size <=> a.favorites.where('created_at >= ?', time).size }
  }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
