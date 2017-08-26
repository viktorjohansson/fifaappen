class AddTableChangesToEvents < ActiveRecord::Migration
  def change
    add_column :events, :table_changes, :string
  end
end
