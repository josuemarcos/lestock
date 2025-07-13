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

materials = [
  {
    amount: 5000,
    price: 20,
    description: "this is the first material",
    supplier_id: 1,
    material_type_id: 1
  },
  {
    amount: 200,
    price: 10,
    description: "this is the second material",
    supplier_id: 2,
    material_type_id: 2
  },
  {
    amount: 1000,
    price: 12,
    description: "this is the third material",
    supplier_id: 3,
    material_type_id: 3
  }
]

puts '------Seeding the database-------'

suppliers.each do |supplier|
  Supplier.create(supplier)
end

material_types.each do |material_type|
  MaterialType.create(material_type)
end

materials.each do |material|
  Material.create(material)
end

puts '------Database seeded!-------'


