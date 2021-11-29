class Track < ApplicationRecord
  belongs_to :album
  has_one_attached :song_link
end
