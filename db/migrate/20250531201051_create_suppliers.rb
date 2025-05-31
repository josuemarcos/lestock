class CreateSuppliers < ActiveRecord::Migration[7.1]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :description
      t.string :phone_number
      t.string :social_media
      t.timestamps
    end
  end
end
