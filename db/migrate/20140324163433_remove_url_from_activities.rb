class RemoveUrlFromActivities < ActiveRecord::Migration
  def change
    remove_column :activities, :url, :string
  end
end
