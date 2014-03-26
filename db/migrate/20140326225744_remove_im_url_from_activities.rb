class RemoveImUrlFromActivities < ActiveRecord::Migration
  def change
    remove_column :activities, :im_url, :string
  end
end
