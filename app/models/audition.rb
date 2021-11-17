class Audition < ApplicationRecord
  require 'csv'
  include DeviseInvitable::Inviter
  include PgSearch::Model
  pg_search_scope :search_by_name, against: [:first_name, :last_name, :email, :artist_name, :status, :genre]
  validates :first_name, :last_name, length: { maximum: 30 }, format: { with: /\A[a-zA-Z0-9 ]*\z/, message: "- No special character allowed", multiline: :true }

  ACCEPT= "Thanks for submitting music to Audiosocket, we have listened to your link and would love to work with you!

Please sign in to our artist portal here. There, you can update your artist profile, submit music, artworks, etc. The more assets you can give us the better. Once submitted, our team will review and will start the ingestion into our catalog.

Thanks!
Music Licensing Coordinator".freeze

  REJECT="Thank you for submitting an audition. After careful review, we’ve decided the music you submitted is not a match for our current needs. Please understand, that while your music may not be a match this time, it certainly might be in the future as our clients’ needs are constantly changing.

With that in mind, we encourage you to submit new music again in the future.

Have a great day!".freeze
  STATUS_MAIL= { accept: ACCEPT, reject: REJECT }

  def self.genre
    ['apella', 'acid', 'jazz', 'acoustic', 'acid_punk', 'alternative', 'hip_hop', 'ambient', 'avantgarde', 'bass', 'blues', 'Cabaret', 'Celtic_chamber', 'Chanson', 'Chorus', 'christian_rap', 'cinematic', 'classical', 'classic_rock', 'club', 'comedy', 'country', 'cult']
  end

  def self.source
    ['Facebook', 'Instagram', 'Twitter', 'other']
  end

  def self.status
    ['pending', 'accepted', 'rejected', 'deleted']
  end

  # def set_default_mail
  #   self.status_mail ||=


#   def self.status_mail
#     ['Hi

# Thanks for submitting music to Audiosocket, we have listened to your link and would love to work with you!

# Please sign in to our artist portal here. There, you can update your artist profile, submit music, artworks, etc. The more assets you can give us the better. Once submitted, our team will review and will start the ingestion into our catalog.

# Thanks!
# Music Licensing Coordinator']
# end

  def self.to_csv
    attributes = %w{id first_name artist_name email genre created_at assigned status}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |audition|
        csv << attributes.map{ |attr| audition.send(attr) }
      end
    end
  end

  def name
    "#{first_name} #{last_name}"
  end
end
