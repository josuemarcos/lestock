require 'dotenv'
require_relative '../app/services/material-type-service'

describe MaterialTypeService do
  let(:material_type_service) {MaterialTypeService.new}

  before(:all) do
    require_relative '../config/environment'
  end

  it 'gets an material type from db' do
    result = material_type_service.get_material_type_by_id(1)
    expect(result).to have_key(:ok)
    expect(result[:ok]).to be true
    expect(result).to have_key(:data)
    expect(result[:data]).to be_truthy
    expect(result[:data][:name]).to eq('cement')
  end

  it 'attempts to get a non-registered material type from db' do
    result = material_type_service.get_material_type_by_id(100)
    expect(result).to have_key(:ok)
    expect(result[:ok]).to be false
    expect(result).to have_key(:msg)
    expect(result[:msg]).to eq('Material type not found!')
  end

  it 'gets all material types from db' do
    result = material_type_service.get_all_material_types
    expect(result).to have_key(:data)
    expect(result[:data]).to be_truthy
    expect(result[:data].length).to eq(3)
  end

  it 'gets a material type passing a string as query parameter' do
    result = material_type_service.get_all_material_types(name: 'rock')
    expect(result).to have_key(:data)
    expect(result[:data]).to be_truthy
    expect(result[:data]).to include(have_attributes(name: 'decorative rocks'))
  end

  it 'attempts to get a non registered material type passing a string as query parameter' do
    result = material_type_service.get_all_material_types(name: 'XPTO')
    expect(result).to have_key(:data)
    expect(result[:data]).to be_truthy
    expect(result[:data]).to eq('No material types registered!')
  end

  it 'register a material type to the db' do
    material_type_sample = {name: "test material type",
    metric_unit: "test metric unit"}
    result = material_type_service.create_material_type(material_type_sample)
    expect(result).to have_key(:ok)
    expect(result[:ok]).to be true
    expect(result).to have_key(:data)
    expect(result[:data]).to be_truthy
    expect(result[:data][:name]).to eq('test material type')
    expect(result[:data][:metric_unit]).to eq('test metric unit')
  end

  it 'attempts to register a material type without a name to the db' do
    material_type_sample = {name: "",
    metric_unit: "test metric unit"}
    result = material_type_service.create_material_type(material_type_sample)
    expect(result).to have_key(:ok)
    expect(result[:ok]).to be false
    expect(result).to have_key(:msg)
    expect(result[:data]).to be_falsy
    expect(result[:msg]).to eq("[\"Name can't be blank\"]")
  end

  it 'attempts to register a material type with name already registered' do
    material_type_sample = {name: "cement",
    metric_unit: "test metric unit"}
    result = material_type_service.create_material_type(material_type_sample)
    expect(result).to have_key(:ok)
    expect(result[:ok]).to be false
    expect(result).to have_key(:msg)
    expect(result[:data]).to be_falsy
    expect(result[:msg]).to eq("[\"Name has already been taken\"]")
  end

  it 'modify a material type on the db' do
    material_type_sample = {name: "test material_type"}
    result = material_type_service.update_material_type(1, material_type_sample)
    expect(result).to have_key(:ok)
    expect(result[:ok]).to be true
    expect(result).to have_key(:data)
    expect(result[:data]).to be_truthy
    expect(result[:data][:name]).to eq('test material_type')
    expect(result[:data][:metric_unit]).to eq('g')
  end

  it 'attempts to set a material type name to blank' do
    material_type_sample = {name: ""}
    result = material_type_service.update_material_type(1, material_type_sample)
    expect(result).to have_key(:ok)
    expect(result[:ok]).to be true
    expect(result).to have_key(:msg)
    expect(result[:data]).to be_falsy
    expect(result[:msg]).to eq("[\"Name can't be blank\"]")
  end

  it 'attempts to update a material type not registered' do
    material_type_sample = {name: "test material_type"}
    result = material_type_service.update_material_type(4, material_type_sample)
    expect(result).to have_key(:ok)
    expect(result[:ok]).to be false
    expect(result).to have_key(:msg)
    expect(result[:data]).to be_falsy
    expect(result[:msg]).to eq("Material type not found!")
  end

  it 'delete a material type from the db' do
    result = material_type_service.delete_material_type(1)
    confirmation = material_type_service.get_material_type_by_id(1)
    expect(result).to have_key(:ok)
    expect(result[:ok]).to be true
    expect(result).to have_key(:msg)
    expect(result[:msg]).to eq("Material type deleted!")
    expect(confirmation[:msg]).to eq('Material type not found!')
  end

   it 'attempts to delete a material type not registered' do
    result = material_type_service.delete_material_type(4)
    expect(result).to have_key(:ok)
    expect(result[:ok]).to be false
    expect(result).to have_key(:msg)
    expect(result[:msg]).to eq("Material type not found!")
  end

end