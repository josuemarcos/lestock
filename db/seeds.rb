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

puts '------Seeding the database-------'

suppliers.each do |supplier|
  Supplier.create(supplier)
end

material_types.each do |material_type|
  MaterialType.create(material_type)
end

puts '------Database seeded!-------'


