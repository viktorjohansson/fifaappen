class AddStreakToStatisticLastTime < ActiveRecord::Migration
  def change
    add_column :statistic_last_times, :win_streak, :integer
    add_column :statistic_last_times, :lose_streak, :integer
    add_column :statistic_last_times, :tie_streak, :integer
    remove_column :statistic_last_times, :streak, :integer
    remove_column :statistic_last_times, :streak_direction, :integer
  end
end
