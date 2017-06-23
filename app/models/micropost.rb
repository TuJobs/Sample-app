class Micropost < ApplicationRecord
  belongs_to :user

  scope :micropost_sort, ->{order created_at: :desc}
  scope :load_feed, ->id{where user_id: id}

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.micropost.max_length}
  validate :picture_size

  private

  def picture_size
    if picture.size > Settings.micropost.size_limit.megabytes
      errors.add :picture, I18n.t(".limit_picture")
    end
  end
end
