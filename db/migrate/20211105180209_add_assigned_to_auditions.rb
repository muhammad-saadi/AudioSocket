class AddAssignedToAuditions < ActiveRecord::Migration[6.1]
  def change
    add_column :auditions, :assigned, :string
  end
end
