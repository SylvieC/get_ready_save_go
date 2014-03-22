class RemoveToCountryFromTrips < ActiveRecord::Migration
  def change
    remove_column :trips, :to_country, :string
  end
end
