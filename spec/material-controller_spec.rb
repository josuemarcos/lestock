require 'dotenv'
require 'rack/test'
require_relative '../app/controllers/material-controller'

describe MaterialController do
  include Rack::Test::Methods

  let(:app) {MaterialController}

  before(:all) do
    require_relative '../config/environment'
  end

  it "test GET all material types" do
    get '/'
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(200)
    expect(hashed_response.length).to eq(3)
  end
  it "test GET material passing the supplier name" do
    get '/?supplier_name=2'
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(200) 
    expect(hashed_response.length).to eq(1)
  end
  it "test GET material passing the material type name" do
    get '/?material_type_name=rock'
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(200) 
    expect(hashed_response.length).to eq(1)
  end
end
