class CreateMaterials < ActiveRecord::Migration[8.0]
  def change
    create_table :materials do |t|
      t.string :name
      t.string :supplier
      t.float :stock
      t.timestamps
    end
  end
end
