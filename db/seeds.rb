materials = [
  {
    amount: "200",
    price: 25,
    price_per_amount: 0.125,
    material_type_id: 2,
    supplier_id: 1
  },
  {
    amount: "20000",
    price: 50,
    price_per_amount: 0.0025,
    material_type_id: 1,
    supplier_id: 2
  },
  {
    amount: "1000",
    price: 20,
    price_per_amount: 0.02,
    material_type_id: 3,
    supplier_id: 3
  }
]

suppliers = [
  {
    name: "supplier 01",
    description: "this supplier sells A",
    phone_number: "123",
    social_media: "supplier@1",
    address: "address_supplier_01"
  },
  {
    name: "supplier 02",
    description: "this supplier sells B",
    phone_number: "456",
    social_media: "supplier@2",
    address: "address_supplier_02"
  },
  {
    name: "supplier 03",
    description: "this supplier sells C",
    phone_number: "789",
    social_media: "supplier@3",
    address: "address_supplier_03"
  }
]

material_types = [
  {
    name: "cement",
    metric_unit: "g"
  },
  {
    name: "glue",
    metric_unit: "ml"
  },
  {
    name: "decorative rocks",
    metric_unit: "g"
  }
]

suppliers.each do |supplier|
  Supplier.create(supplier)
end

material_types.each do |material_type|
  MaterialType.create(material_type)
end

materials.each do |attrs|
  mat = Material.create(attrs)
  puts "Created? #{mat.persisted?}, Name: #{mat.name.inspect}"
end


