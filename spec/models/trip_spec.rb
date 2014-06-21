require 'spec_helper'

describe Trip do
 it "is is invalid if from_city is nil" do
  Trip = Trip.new(
   from_city: "San Francisco, USA",
   to_city: "Paris, France",
   cost:  1200,
   start_date: "2014-05-23 00:00:00",
   title:  "La France",
   user_id: 10

    )
 end
end
