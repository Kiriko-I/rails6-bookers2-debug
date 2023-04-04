class Book < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :book_comments, dependent: :destroy
  has_many :book_view_counts, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  scope :created_today, -> { where(created_at: Time.current.all_day) }
  scope :created_yesterday, -> { where(created_at: Time.current.yesterday.all_day) }
  scope :created_this_week, -> { where(created_at: Time.current.ago(6.days)...Time.current) }
  scope :created_last_week, -> { where(created_at: Time.current.ago(7.days)...Time.current.ago(13.days)) }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
