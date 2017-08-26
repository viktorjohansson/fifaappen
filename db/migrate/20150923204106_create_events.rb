class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :message
      t.string :title

      t.timestamps
    end
  end
end
