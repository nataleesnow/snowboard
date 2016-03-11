class CreateLiftPass < ActiveRecord::Migration
  def change
    create_table :lift_passes do |t|
      t.belongs_to :owner, index: true
      t.integer :season_id, index: true
      t.string :service_url
      t.string :wtp_number
    end
  end

  def down
    drop_table :lift_passes
  end

end
