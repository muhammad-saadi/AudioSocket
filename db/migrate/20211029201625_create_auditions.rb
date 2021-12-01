class CreateAuditions < ActiveRecord::Migration[6.1]
  def change
    create_table :auditions do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :artist_name
      t.string :song_link, array: true
      t.string :additional_info

      t.timestamps
    end
  end
end
