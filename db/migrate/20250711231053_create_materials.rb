class CreateMaterials < ActiveRecord::Migration[7.1]
  def change
    create_table :materials do |t|
      t.float :amount
      t.float :price
      t.virtual :price_per_amount,
                type: :float,
                as: "price / NULLIF(amount, 0)",
                stored: true
      t.string :description
      t.references :material_type, foreign_key: true
      t.references :supplier, foreign_key: true
      t.timestamps
    end
    
  end
end
