class RemoveMonthsBeforeDepartureFromTrips < ActiveRecord::Migration
  def change
    remove_column :trips, :months_before_departure, :integer
  end
end
