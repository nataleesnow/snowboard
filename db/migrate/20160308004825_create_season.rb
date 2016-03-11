class CreateSeason < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.string :begin_year
      t.string :end_year
    end
  end

  def down
    drop_table :seasons
  end
end
