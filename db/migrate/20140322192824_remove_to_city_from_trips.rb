class RemoveToCityFromTrips < ActiveRecord::Migration
  def change
   
    remove_column :trips, :days_before_departure, :integer
    remove_column :trips, :months_before_departure, :integer
   
  end
end
