class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :from_city
      t.string :from_country
      t.string :to_city
      t.string :to_country
      t.float :money_saved
      t.float :add_to_money_saved
      t.float :cost
      t.integer :days_before_departure
      t.integer :months_before_departure

      t.timestamps
    end
  end
end
