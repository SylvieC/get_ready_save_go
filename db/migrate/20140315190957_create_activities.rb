class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.text :im_url , limit: 2000
      t.string :category
      t.belongs_to :trip, index: true

      t.timestamps
    end
  end
end
