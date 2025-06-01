class CreateMaterials < ActiveRecord::Migration[7.1]
  def change
    create_table :materials do |t|
      t.string :name
      t.float :stock
      t.string :metric_unit
      t.timestamps
    end
  end
end
