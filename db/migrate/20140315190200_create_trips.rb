class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :from_city
      t.string :to_city
      t.float :cost
      t.datetime :start_date
      t.string :title
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
