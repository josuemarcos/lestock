require 'dotenv'
require_relative '../app/models/suppliers-model'

describe Supplier do
  let(:supplier) {Supplier.new}

  before(:all) do
    require_relative '../config/environment'
  end

  it 'gets an supplier from db' do
    result = supplier.get_supplier_by_id(1)
    expect(result).to have_key(:status)
    expect(result[:status]).to eq(200)
    expect(result).to have_key(:data)
    expect(result[:data]).to be_truthy
    expect(result[:data][:name]).to eq('supplier 01')
  end

  it 'attempts to get a non-registered supplier from db' do
    result = supplier.get_supplier_by_id(100)
    expect(result).to have_key(:status)
    expect(result[:status]).to eq(404)
    expect(result).to have_key(:data)
    expect(result[:data]).to eq('Supplier not found!')
  end

  it 'gets all suppliers from db' do
    result = supplier.get_all_suppliers
    expect(result).to have_key(:data)
    expect(result[:data]).to be_truthy
    expect(result[:data].length).to eq(3)
  end

  it 'gets a supplier passing a string as query parameter' do
    result = supplier.get_all_suppliers(name: '2')
    expect(result).to have_key(:data)
    expect(result[:data]).to be_truthy
    expect(result[:data]).to include(have_attributes(name: 'supplier 02'))
  end

  it 'attempts to get a non registered supplier passing a string as query parameter' do
    result = supplier.get_all_suppliers(name: 'XPTO')
    expect(result).to have_key(:data)
    expect(result[:data]).to be_truthy
    expect(result[:data]).to eq('No suppliers registered!')
  end

  it 'register a supplier to the db' do
    supplier_sample = {name: "test supplier",
    description: "test description",
    phone_number: "123",
    social_media: "test",
    address: "address_test"}
    result = supplier.create_supplier(supplier_sample)
    expect(result).to have_key(:status)
    expect(result[:status]).to eq(201)
    expect(result).to have_key(:msg)
    expect(result[:msg]).to eq('Supplier registered!')
    expect(result).to have_key(:data)
    expect(result[:data]).to be_truthy
    expect(result[:data][:name]).to eq('test supplier')
    expect(result[:data][:description]).to eq('test description')
    expect(result[:data][:phone_number]).to eq('123')
    expect(result[:data][:social_media]).to eq('test')
    expect(result[:data][:address]).to eq('address_test')
  end

  it 'attempts to register a supplier without a name to the db' do
    supplier_sample = {
    description: "test description",
    phone_number: "123",
    social_media: "test",
    address: "address_test"}
    result = supplier.create_supplier(supplier_sample)
    expect(result).to have_key(:status)
    expect(result[:status]).to eq(422)
    expect(result).to have_key(:msg)
    expect(result[:data]).to be_falsy
    expect(result[:msg]).to eq("[\"Name can't be blank\"]")
  end

  it 'attempts to register a supplier with name already registered' do
    supplier_sample = {
    name: "supplier 01",
    description: "test description",
    phone_number: "123",
    social_media: "test",
    address: "address_test"}
    result = supplier.create_supplier(supplier_sample)
    expect(result).to have_key(:status)
    expect(result[:status]).to eq(422)
    expect(result).to have_key(:msg)
    expect(result[:data]).to be_falsy
    expect(result[:msg]).to eq("[\"Name has already been taken\"]")
  end

  it 'modify a supplier on the db' do
    supplier_sample = {name: "test supplier"}
    result = supplier.update_supplier(1, supplier_sample)
    expect(result).to have_key(:status)
    expect(result[:status]).to eq(200)
    expect(result).to have_key(:data)
    expect(result[:data]).to be_truthy
    expect(result[:data][:name]).to eq('test supplier')
    expect(result[:data][:description]).to eq('this supplier sells A')
    expect(result[:data][:phone_number]).to eq('123')
    expect(result[:data][:social_media]).to eq('supplier@1')
    expect(result[:data][:address]).to eq('address_supplier_01')
  end

  it 'attempts to set a supplier name to blank' do
    supplier_sample = {name: ""}
    result = supplier.update_supplier(1, supplier_sample)
    expect(result).to have_key(:status)
    expect(result[:status]).to eq(422)
    expect(result).to have_key(:msg)
    expect(result[:data]).to be_falsy
    expect(result[:msg]).to eq("[\"Name can't be blank\"]")
  end

  it 'attempts to update a supplier not registered' do
    supplier_sample = {name: "test supplier"}
    result = supplier.update_supplier(4, supplier_sample)
    expect(result).to have_key(:status)
    expect(result[:status]).to eq(404)
    expect(result).to have_key(:msg)
    expect(result[:data]).to be_falsy
    expect(result[:msg]).to eq("Supplier not found!")
  end

  it 'delete a supplier from the db' do
    result = supplier.delete_supplier(1)
    confirmation = supplier.get_supplier_by_id(1)
    expect(result).to have_key(:status)
    expect(result[:status]).to eq(200)
    expect(result).to have_key(:msg)
    expect(result[:msg]).to eq("Supplier deleted!")
    expect(confirmation).to have_key(:data)
    expect(confirmation[:data]).to eq('Supplier not found!')
  end

   it 'attempts to delete a supplier not registered' do
    result = supplier.delete_supplier(4)
    expect(result).to have_key(:status)
    expect(result[:status]).to eq(404)
    expect(result).to have_key(:msg)
    expect(result[:msg]).to eq("Supplier not found!")
  end

end