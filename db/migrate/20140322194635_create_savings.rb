class CreateSavings < ActiveRecord::Migration
  def change
    create_table :savings do |t|
      t.float :amount, :default => 0
      t.references :trip, index: true

      t.timestamps
    end
  end
end
