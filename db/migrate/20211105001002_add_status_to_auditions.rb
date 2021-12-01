class AddStatusToAuditions < ActiveRecord::Migration[6.1]
  def change
    add_column :auditions, :status, :text, default: 'pending'
  end
end
