require_relative 'config/environment'

map "/suppliers" do
  run SupplierController.new
end