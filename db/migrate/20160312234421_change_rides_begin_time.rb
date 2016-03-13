class ChangeRidesBeginTime < ActiveRecord::Migration
  def change
    change_column :rides, :begin_time, :string
  end
end
