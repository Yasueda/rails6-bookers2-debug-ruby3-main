class Group < ApplicationRecord
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
  validates :name, presence: true, uniqueness: true
  has_one_attached :group_image

  def get_group_image
    (group_image.attached?) ? group_image : 'no_image.jpg'
  end

  def joined_by?(user)
    user_groups.exists?(user_id: user.id)
  end
end
