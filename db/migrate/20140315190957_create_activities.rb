class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.string :image
      t.string :url
      t.string :comment
      t.string :type

      t.timestamps
    end
  end
end
