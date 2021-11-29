class Album < ApplicationRecord
  belongs_to :artist_profile
  has_one_attached :artwork
  has_many :tracks
end
