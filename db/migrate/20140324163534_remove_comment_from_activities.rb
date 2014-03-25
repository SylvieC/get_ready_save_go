class RemoveCommentFromActivities < ActiveRecord::Migration
  def change
    remove_column :activities, :comment, :string
  end
end
