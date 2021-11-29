class AddAlbumReferenceToTrack < ActiveRecord::Migration[6.1]
  def change
    add_reference :tracks, :album, null: false, foreign_key: true
  end
end
