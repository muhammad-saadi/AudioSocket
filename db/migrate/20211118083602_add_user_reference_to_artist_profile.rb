class AddUserReferenceToArtistProfile < ActiveRecord::Migration[6.1]
  def change
    add_reference :artist_profiles, :user, null: false, foreign_key: true
  end
end
