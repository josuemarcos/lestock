class CreateMaterials < ActiveRecord::Migration[7.1]
  def change
    create_table :materials do |t|
      t.float :amount
      t.float :price
      t.float :price_per_amount
      t.string :observation
      t.timestamps
    end
  end
end
