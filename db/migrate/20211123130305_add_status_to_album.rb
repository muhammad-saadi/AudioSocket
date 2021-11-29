class AddStatusToAlbum < ActiveRecord::Migration[6.1]
  def change
    add_column :albums, :status, :string, default: "submit"
  end
end
