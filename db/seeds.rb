materials = [
  {
    'name': 'cimento',
    'supplier': 'loja1',
    'stock': '200,5'
  },
  {
    'name': 'cera',
    'supplier': 'loja2',
    'stock': '125,8'
  },
  {
    'name': 'tinta',
    'supplier': 'loja3',
    'stock': '80,35'
  }
]

materials.each do |material|
  Material.create(material)
end
