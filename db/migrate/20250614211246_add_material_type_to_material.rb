class AddMaterialTypeToMaterial < ActiveRecord::Migration[7.1]
  def change
    add_reference :materials, :material_type, null: false, foreign_key: true
  end
end
