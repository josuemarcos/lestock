require 'sinatra/base'
require 'sinatra/activerecord'


class App < Sinatra::Base
  register Sinatra::ActiveRecordExtension
end