class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks
  has_one_attached :photo
  validates :name, presence: true, uniqueness: true

  def cover_image
    if photo.attached?
      photo.url
    else
      image_url.presence || movies.first&.poster_url
    end
  end

end
