class Audition < ApplicationRecord
  validates :first_name, :last_name, length: { maximum: 30 }, format: { with: /\A[a-zA-Z0-9 ]*\z/, message: "- No special character allowed", multiline: :true }

  def self.genre
    ['apella', 'acid', 'jazz', 'acoustic', 'acid_punk', 'alternative', 'hip_hop', 'ambient', 'avantgarde', 'bass', 'blues', 'Cabaret', 'Celtic_chamber', 'Chanson', 'Chorus', 'christian_rap', 'cinematic', 'classical', 'classic_rock', 'club', 'comedy', 'country', 'cult']
  end

  def self.source
    ['Facebook', 'Instagram', 'Twitter', 'other']
  end
end
