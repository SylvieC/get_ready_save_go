class RemoveActivityIdFromLinks < ActiveRecord::Migration
  def change
    remove_column :links, :activity_id, :integer
  end
end
