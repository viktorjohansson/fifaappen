class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.references :player, index: true
      t.string :type

      t.timestamps
    end
  end
end
