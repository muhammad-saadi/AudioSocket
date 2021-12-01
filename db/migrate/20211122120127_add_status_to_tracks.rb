class AddStatusToTracks < ActiveRecord::Migration[6.1]
  def change
    add_column :tracks, :status, :string, default: 'submit'
  end
end
