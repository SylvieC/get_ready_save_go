class RemoveFromCountryFromTrips < ActiveRecord::Migration
  def change
    remove_column :trips, :from_country, :string
  end
end
