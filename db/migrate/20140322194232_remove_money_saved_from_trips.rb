class RemoveMoneySavedFromTrips < ActiveRecord::Migration
  def change
    remove_column :trips, :money_saved, :float
  end
end
