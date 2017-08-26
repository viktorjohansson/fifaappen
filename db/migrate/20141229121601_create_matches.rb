class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :home
      t.integer :away

      t.timestamps
    end
  end
end
