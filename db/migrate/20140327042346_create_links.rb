class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title
      t.string :category
      t.text :content
      t.belongs_to :activity

      t.timestamps
      
    end
  end
end
