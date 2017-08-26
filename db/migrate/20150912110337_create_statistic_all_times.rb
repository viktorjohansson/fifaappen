class CreateStatisticAllTimes < ActiveRecord::Migration
  def change
    create_table :statistic_all_times do |t|
      t.references :player, index: true
      t.integer :wins
      t.integer :losses
      t.integer :ties
      t.integer :goals_for
      t.integer :goals_against
      t.integer :streak
      t.integer :streak_direction
      t.integer :balance

      t.timestamps
    end
  end
end
