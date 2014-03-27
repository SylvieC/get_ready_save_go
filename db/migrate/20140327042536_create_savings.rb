class CreateSavings < ActiveRecord::Migration
  def change
    create_table :savings do |t|
      t.float :amount
      t.belongs_to :trip

      t.timestamps
      
    end
  end
end
