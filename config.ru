require_relative 'config/environment'

map "/suppliers" do
  run SupplierRouter.new
end