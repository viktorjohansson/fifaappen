class AddStreakToStatisticLastSeason < ActiveRecord::Migration
  def change
    add_column :statistic_last_seasons, :win_streak, :integer
    add_column :statistic_last_seasons, :lose_streak, :integer
    add_column :statistic_last_seasons, :tie_streak, :integer
    remove_column :statistic_last_seasons, :streak, :integer
    remove_column :statistic_last_seasons, :streak_direction, :integer
  end
end
