class AddArtistProfileReferenceToAlbum < ActiveRecord::Migration[6.1]
  def change
    add_reference :albums, :artist_profile, null: false, foreign_key: true
  end
end
