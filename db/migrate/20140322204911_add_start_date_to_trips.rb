class AddStartDateToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :start_date, :string
  end
end
