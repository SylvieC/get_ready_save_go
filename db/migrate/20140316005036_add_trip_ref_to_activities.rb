class AddTripRefToActivities < ActiveRecord::Migration
  def change
    add_reference :activities, :trip, index: true
  end
end
