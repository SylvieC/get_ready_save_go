class AddActivityRefToLinks < ActiveRecord::Migration
  def change
    add_reference :links, :activity, index: true
  end
end
