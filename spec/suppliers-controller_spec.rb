require 'dotenv'
require_relative '../app/controllers/suppliers-controller'

describe SupplierController do
  let(:controller) {SupplierController.new}

  before(:all) do
    require_relative '../config/environment'
  end

  it 'gets an supplier from db' do
    result = controller.get_supplier_by_id(1)
    expect(result).to have_key(:status)
    expect(result).to have_key(:data)
    expect(result[:status]).to eq(200)
    expect(result[:data]).to be_truthy
    expect(result[:data][:name]).to eq('supplier 01')
  end

  it 'attempts to get a non-registered supplier from db' do
    result = controller.get_supplier_by_id(100)
    expect(result).to have_key(:status)
    expect(result).to have_key(:data)
    expect(result[:status]).to eq(404)
    expect(result[:data]).to eq('Supplier not found!')
  end

  it 'gets all suppliers from db' do
    result = controller.get_all_suppliers
    expect(result).to have_key(:data)
    expect(result[:data]).to be_truthy
    expect(result[:data].length).to eq(4)
  end

  it 'gets a supplier passing a string as query parameter' do
    result = controller.get_all_suppliers(name: '2')
    expect(result).to have_key(:data)
    expect(result[:data]).to be_truthy
    expect(result[:data]).to include(have_attributes(name: 'supplier 02'))
  end
end