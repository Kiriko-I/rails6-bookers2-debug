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
  scope :created_2days_ago, -> { where(created_at: Time.current.ago(2.days).all_day) }
  scope :created_3days_ago, -> { where(created_at: Time.current.ago(3.days).all_day) }
  scope :created_4days_ago, -> { where(created_at: Time.current.ago(4.days).all_day) }
  scope :created_5days_ago, -> { where(created_at: Time.current.ago(5.days).all_day) }
  scope :created_6days_ago, -> { where(created_at: Time.current.ago(6.days).all_day) }
  scope :created_this_week, -> { where(created_at: Time.current.ago(6.days).beginning_of_day..Time.current.end_of_day) }
  scope :created_last_week, -> { where(created_at: Time.current.ago(2.weeks).beginning_of_day..Time.current.ago(1.week).end_of_day) }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
