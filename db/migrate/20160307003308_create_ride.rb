class CreateRide < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.belongs_to :lift_pass, index: true
      t.integer :vert
      t.date :day
      t.time :begin_time
    end
  end

  def down
    drop_table :rides
  end
end
