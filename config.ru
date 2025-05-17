require_relative 'config/environment'

map "/materials" do
  run MaterialRouter.new
end