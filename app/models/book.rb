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
  scope :new_order, -> { order(created_at: :desc) }
  scope :old_order, -> { order(created_at: :asc) }
  scope :star_order, -> { order(star: :desc) }

  scope :today_books, -> { where(created_at: Time.zone.now.all_day) }
  scope :yesterday_books, -> { where(created_at: Time.zone.now.yesterday.all_day) }
  scope :thisweek_books, -> { where(created_at: Time.zone.now.prev_week(:saturday)..Time.zone.now) }
  scope :lastweek_books, -> { where(created_at: Time.zone.now.last_week.prev_week(:saturday)..Time.zone.now.prev_week(:friday).end_of_day) }

  scope :lastday_books, -> (day) { where(created_at: Time.zone.now.ago(day.days).all_day) }
  scope :date_books, -> (date) { where(created_at: date.all_day) }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
