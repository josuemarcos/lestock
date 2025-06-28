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
  if res[:ok]
    status 200
    {supplier: res[:data]}.to_json
  else
    status 404
    {msg: res[:msg]}.to_json
  end
end

post '/' do
  payload = JSON.parse(request.body.read)
  res = @supplier.create_supplier(payload)
  if res[:ok]
    status 201
    {supplier: res[:data]}.to_json
  else
    status 422
    {msg: res[:msg]}.to_json
  end
end

patch '/:id' do
  payload = JSON.parse(request.body.read)
  res = @supplier.update_supplier(params[:id], payload)
  if res[:ok]
    if res[:data]
      status 200
      {supplier: res[:data]}.to_json
    else
      status 422
      {msg: res[:msg]}.to_json
    end
  else
    status 404
    {msg: res[:msg]}.to_json
  end
end

delete '/:id' do
  res = @supplier.delete_supplier(params[:id])
  if res[:ok]
    status 200
    {msg: res[:msg]}.to_json
  else
    status 404
    {msg: res[:msg]}.to_json
  end
end

end