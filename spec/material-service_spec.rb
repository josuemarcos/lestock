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


end
