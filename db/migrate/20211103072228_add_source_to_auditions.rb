class AddSourceToAuditions < ActiveRecord::Migration[6.1]
  def change
    add_column :auditions, :source, :text, array: true
  end
end
