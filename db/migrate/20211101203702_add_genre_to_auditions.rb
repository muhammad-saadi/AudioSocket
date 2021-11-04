class AddGenreToAuditions < ActiveRecord::Migration[6.1]
  def change
    add_column :auditions, :genre, :text, array: true
  end
end
