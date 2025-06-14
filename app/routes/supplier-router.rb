require 'sinatra'
require_relative '../controllers/suppliers-controller'

class SupplierRouter < Sinatra::Base
  def initialize
    super
    @supplier_controller = SupplierController.new
  end

before do
  content_type :json
end

get '/' do
  res = @supplier_controller.get_all_suppliers(params)
  status res[:status].to_json
  return res[:data].to_json
end

end

