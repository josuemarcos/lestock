require_relative 'config/environment'

map "/suppliers" do
  run SupplierController.new
end

map "/material-types" do
  run MaterialTypeController.new
end

map "/materials" do
  run MaterialController.new
end