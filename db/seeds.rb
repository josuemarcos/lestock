materials = [
  {
    'name': 'cimento',
    'stock': '200,5',
    'metric_unit': 'g',
    'supplier_id': '1'
  },
  {
    'name': 'cera',
    'stock': '125,8',
    'metric_unit': 'g',
    'supplier_id': '2'
  },
  {
    'name': 'tinta',
    'stock': '80,35',
    'metric_unit': 'ml',
    'supplier_id': '3'
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

suppliers.each do |supplier|
  Supplier.create(supplier)
end

materials.each do |material|
  Material.create(material)
end
