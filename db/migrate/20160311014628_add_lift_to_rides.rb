class AddLiftToRides < ActiveRecord::Migration
  def change
    add_column :rides, :lift, :string
  end
end
