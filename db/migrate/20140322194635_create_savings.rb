class CreateSavings < ActiveRecord::Migration
  def change
    create_table :savings do |t|
      t.float :amount
      t.references :trip, index: true

      t.timestamps
    end
  end
end
