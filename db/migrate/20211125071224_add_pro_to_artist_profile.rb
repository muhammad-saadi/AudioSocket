class AddProToArtistProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :artist_profiles, :pro, :boolean, default: false
  end
end
