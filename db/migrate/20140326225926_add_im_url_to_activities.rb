class AddImUrlToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :im_url, :text
  end
end
