class AddScheduleToRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :schedule, :text
  end
end
