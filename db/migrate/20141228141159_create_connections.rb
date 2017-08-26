class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.belongs_to :player, index: true
      t.belongs_to :team, index: true

      t.timestamps
    end
  end
end
