class AddMetricUnitToMaterials < ActiveRecord::Migration[7.1]
  def change
    add_column :materials, :metric_unit, :string
  end
end
