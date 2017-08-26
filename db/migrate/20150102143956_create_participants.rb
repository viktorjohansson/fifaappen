class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.belongs_to :player, index: true
      t.belongs_to :round, index: true
      t.belongs_to :match, index: true

      t.timestamps
    end
  end
end
