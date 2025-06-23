require 'sinatra'
require_relative '../models/suppliers-model'

class SupplierController < Sinatra::Base
  def initialize
    super
    @supplier = Supplier.new
  end

before do
  content_type :json
end

get '/' do
  res = @supplier.get_all_suppliers(params)
  return res[:data].to_json
end

get '/:id' do
  res = @supplier.get_supplier_by_id(params[:id])
  status res[:status].to_json
  return res[:data].to_json
end

post '/' do
  payload = JSON.parse(request.body.read)
  res = @supplier.create_supplier(payload)
  status res[:status].to_json
  return res[:msg].to_json, res[:data].to_json
end

patch '/:id' do
  payload = JSON.parse(request.body.read)
  res = @supplier.update_supplier(params[:id], payload)
  status res[:status].to_json
  return res[:msg].to_json, res[:data].to_json
end

delete '/:id' do
  res = @supplier.delete_supplier(params[:id])
  status res[:status].to_json
  return res[:msg].to_json
end

end