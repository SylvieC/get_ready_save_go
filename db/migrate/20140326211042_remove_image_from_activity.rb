class RemoveImageFromActivity < ActiveRecord::Migration
  def change
    remove_column :activities, :image, :string
  end
end
