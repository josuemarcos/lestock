require 'dotenv'
require_relative '../app/services/material-service'

describe MaterialService do
  let(:material_service) { MaterialService.new } 

  before(:all) do
    require_relative '../config/environment'
  end
  it 'gets all materials from db' do
    result = material_service.get_all_materials
    expect(result).to have_key(:data)
    expect(result[:data]).to be_truthy
    expect(result[:data].length).to eq(3)
  end
  it 'gets a material passing the supplier name' do
    result = material_service.get_all_materials(supplier_name: '2')
    expect(result).to have_key(:data)
    expect(result[:data]).to be_truthy
    expect(result[:data].length).to eq(1)
  end
  it 'gets a material passing the material type name' do
    result = material_service.get_all_materials(material_type_name: 'rock')
    expect(result).to have_key(:data)
    expect(result[:data]).to be_truthy
    expect(result[:data].length).to eq(1)
  end
  it 'gets a material from db' do
    result = material_service.get_material_by_id(1)
    expect(result).to have_key(:ok)
    expect(result[:ok]).to be true
    expect(result).to have_key(:data)
    expect(result[:data]).to be_truthy
    expect(result[:data][:amount]).to eq(5000)
  end

  it 'attempts to get a non registered material passing the supplier name' do
    result = material_service.get_all_materials(supplier_name: 'XPTO')
    expect(result).to have_key(:data)
    expect(result[:data]).to be_truthy
    expect(result[:data]).to eq('No materials registered!')
  end

  it 'attempts to get a non registered material passing the material type name' do
    result = material_service.get_all_materials(material_type_name: 'XPTO')
    expect(result).to have_key(:data)
    expect(result[:data]).to be_truthy
    expect(result[:data]).to eq('No materials registered!')
  end

  it 'attempts to get a non-registered material from db' do
    result = material_service.get_material_by_id(100)
    expect(result).to have_key(:ok)
    expect(result[:ok]).to be false
    expect(result).to have_key(:msg)
    expect(result[:msg]).to eq('Material not found!')
  end

  it 'register a material to the db' do
    material_sample = {amount: 999,
    price: 99,
    description: "Test description",
    supplier_id: "1",
    material_type_id: "2"}
    result = material_service.create_material(material_sample)
    expect(result).to have_key(:ok)
    expect(result[:ok]).to be true
    expect(result).to have_key(:data)
    expect(result[:data]).to be_truthy
    expect(result[:data][:amount]).to eq(999)
    expect(result[:data][:price]).to eq(99)
    expect(result[:data][:description]).to eq('Test description')
    expect(result[:data][:supplier_id]).to eq(1)
    expect(result[:data][:material_type_id]).to eq(2)
  end

  it 'attempts to register a material without supplier id to the db' do
    material_sample = {amount: 999,
    price: 99,
    description: "Test description",
    supplier_id: "",
    material_type_id: "2"}
    result = material_service.create_material(material_sample)
    expect(result).to have_key(:ok)
    expect(result[:ok]).to be false
    expect(result).to have_key(:msg)
    expect(result[:data]).to be_falsy
    expect(result[:msg]).to eq("[\"Supplier is required\"]")
  end

  it 'attempts to register a material with a supplier not registered in the db' do
    material_sample = {amount: 999,
    price: 99,
    description: "Test description",
    supplier_id: "99",
    material_type_id: "2"}
    result = material_service.create_material(material_sample)
    expect(result).to have_key(:ok)
    expect(result[:ok]).to be false
    expect(result).to have_key(:msg)
    expect(result[:data]).to be_falsy
    expect(result[:msg]).to eq("[\"Supplier must be a valid existing supplier\"]")
  end

  it 'attempts to register a material without material type id to the db' do
    material_sample = {amount: 999,
    price: 99,
    description: "Test description",
    supplier_id: "2",
    material_type_id: ""}
    result = material_service.create_material(material_sample)
    expect(result).to have_key(:ok)
    expect(result[:ok]).to be false
    expect(result).to have_key(:msg)
    expect(result[:data]).to be_falsy
    expect(result[:msg]).to eq("[\"Material type is required\"]")
  end

  it 'attempts to register a material with a material type not registered in the db' do
    material_sample = {amount: 999,
    price: 99,
    description: "Test description",
    supplier_id: "2",
    material_type_id: "99"}
    result = material_service.create_material(material_sample)
    expect(result).to have_key(:ok)
    expect(result[:ok]).to be false
    expect(result).to have_key(:msg)
    expect(result[:data]).to be_falsy
    expect(result[:msg]).to eq("[\"Material type must be a valid existing material type\"]")
  end

  it 'attempts to register a material with a material type that is already registered for a supplier' do
    material_sample = {amount: 999,
    price: 99,
    description: "Test description",
    supplier_id: "1",
    material_type_id: "1"}
    result = material_service.create_material(material_sample)
    expect(result).to have_key(:ok)
    expect(result[:ok]).to be false
    expect(result).to have_key(:msg)
    expect(result[:data]).to be_falsy
    expect(result[:msg]).to eq("[\"Material type is already registered for this supplier!\"]")
  end


end
