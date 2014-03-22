class RemoveAddToMoneySavedFromTrips < ActiveRecord::Migration
  def change
    remove_column :trips, :add_to_money_saved, :float
  end
end
