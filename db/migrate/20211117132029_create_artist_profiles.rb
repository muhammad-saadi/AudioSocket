class CreateArtistProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :artist_profiles do |t|
      t.string :email
      t.string :artist_name
      t.string :country
      t.text :bio
      t.string :social_link, array: true
      t.string :website_link

      t.timestamps
    end
  end
end
