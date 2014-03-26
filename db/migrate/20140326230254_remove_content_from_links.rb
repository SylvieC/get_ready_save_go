class RemoveContentFromLinks < ActiveRecord::Migration
  def change
    remove_column :links, :content, :string
  end
end
