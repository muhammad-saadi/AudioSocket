class ArtistProfile < ApplicationRecord
  belongs_to :user
  has_many :albums
  has_one_attached :avatar
  def self.country
    ["pakistan", "india", "australia", "canada", "afghanistan"]
  end
end
