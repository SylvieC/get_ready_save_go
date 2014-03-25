class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title
      t.string :type
      t.string :content
      t.belongs_to :activity, index: true

      t.timestamps
    end
  end
end
