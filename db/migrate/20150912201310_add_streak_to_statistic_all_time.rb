class AddStreakToStatisticAllTime < ActiveRecord::Migration
  def change
    add_column :statistic_all_times, :win_streak, :integer
    add_column :statistic_all_times, :lose_streak, :integer
    add_column :statistic_all_times, :tie_streak, :integer
    remove_column :statistic_all_times, :streak, :integer
    remove_column :statistic_all_times, :streak_direction, :integer
  end
end
