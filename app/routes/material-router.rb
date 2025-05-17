require 'sinatra'

class MaterialRouter < Sinatra::Base

  get '/' do
    'Get all materials endpoint'
  end
  
end
