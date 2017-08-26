class AddBetToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :bet, :integer
  end
end
