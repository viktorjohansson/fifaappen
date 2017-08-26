class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.belongs_to :team, index: true
      t.belongs_to :match, index: true

      t.timestamps
    end
  end
end
