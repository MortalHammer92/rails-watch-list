class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks
  validates :name, presence: true, uniqueness: true

  def cover_image
    image_url.presence || movies.first&.poster_url
  end

end
