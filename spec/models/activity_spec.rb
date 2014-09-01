require 'spec_helper'

describe Activity do
  
 
  # it "creates the activity with the proper name, category, and foreign key" do
  # activity = trip.activities.create(name: 'Eiffel Tower', category: 'entertainment')
  # activity.name.shoud be 'Eiffel Tower'
  # activity.category.shoud be 'entertainment'
  # activity.trip_id.shoul be trip.id
  # end

end

 

=begin
 create_table "activities", force: true do |t|
    t.string   "name"
    t.text     "im_url"
    t.string   "category"
    t.integer  "trip_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
=end
