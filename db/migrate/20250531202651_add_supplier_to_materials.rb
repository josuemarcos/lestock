class AddSupplierToMaterials < ActiveRecord::Migration[7.1]
  def change
    add_reference :materials, :supplier, null: false, foreign_key: true
  end
end
