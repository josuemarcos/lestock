materials = [
  {
    'name': 'cimento',
    'supplier': 'loja1',
    'stock': '200,5',
    'metric_unit': 'g'
  },
  {
    'name': 'cera',
    'supplier': 'loja2',
    'stock': '125,8',
    'metric_unit': 'g'
  },
  {
    'name': 'tinta',
    'supplier': 'loja3',
    'stock': '80,35',
    'metric_unit': 'ml'
  }
]

materials.each do |material|
  Material.create(material)
end
