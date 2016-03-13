class AddTotalToLiftPass < ActiveRecord::Migration
  def change
    add_column :lift_passes, :total, :integer
  end
end
