class AddDefaultValueToAmount < ActiveRecord::Migration
  def up
    change_column :savings, :amount, :float, :default => 0
  end
end
