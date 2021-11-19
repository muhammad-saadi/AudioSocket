class AddStatusMailToAuditions < ActiveRecord::Migration[6.1]
  def change
    add_column :auditions, :status_mail, :text
  end
end
