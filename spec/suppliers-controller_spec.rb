require 'dotenv'
require 'rack/test'
require_relative '../app/controllers/suppliers-controller'

describe SupplierController do
  include Rack::Test::Methods
 
  let(:app) {SupplierController}

  before(:all) do
    require_relative '../config/environment'
  end
  
  it "test GET all suppliers" do
    get '/'
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(200)
    expect(hashed_response.length).to eq(3)
  end

  it "test GET suppliers using query string" do
    get '/?name=2'
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(200) 
    expect(hashed_response.length).to eq(1)
  end

  it "test get supplier by id endpoint GET/1" do
    get '/1'
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(200) 
    expect(hashed_response).to have_key("supplier")
    expect(hashed_response["supplier"]).to be_truthy
  end

  it "test get supplier by id endpoint GET/99" do
    get '/99'
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(404) 
    expect(hashed_response).to have_key("msg")
    expect(hashed_response["msg"]).to be_truthy
  end

  it "test create supplier endpoint" do
    post(
      '/', 
      JSON.generate("name" => "test supplier",
      "description" => "test description",
      "phone_number" => "123",
      "social_media" => "test",
      "address" => "address_test"),
      'CONTENT_TYPE' => 'application/json'
    ) 
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(201) 
    expect(hashed_response).to have_key("supplier")
    expect(hashed_response["supplier"]).to be_truthy
  end

  it "test create supplier endpoint without passing name parameter" do
    post(
      '/', 
      JSON.generate("name" => "",
      "description" => "test description",
      "phone_number" => "123",
      "social_media" => "test",
      "address" => "address_test"),
      'CONTENT_TYPE' => 'application/json'
    ) 
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(422) 
    expect(hashed_response).to have_key("msg")
    expect(hashed_response["msg"]).to be_truthy
  end
  
  it "test create supplier endpoint passing a name already registered" do
    post(
      '/', 
      JSON.generate("name" => "supplier 01",
      "description" => "test description",
      "phone_number" => "123",
      "social_media" => "test",
      "address" => "address_test"),
      'CONTENT_TYPE' => 'application/json'
    ) 
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(422) 
    expect(hashed_response).to have_key("msg")
    expect(hashed_response["msg"]).to be_truthy
  end

  it "test update supplier endpoint PATCH/1" do
    patch(
      '/1', 
      JSON.generate("name" => "test"),
      'CONTENT_TYPE' => 'application/json'
    ) 
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(200) 
    expect(hashed_response).to have_key("supplier")
    expect(hashed_response["supplier"]).to be_truthy
  end
  
  it "test update supplier endpoint PATCH/99" do
    patch(
      '/99', 
      JSON.generate("name" => "test"),
      'CONTENT_TYPE' => 'application/json'
    ) 
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(404) 
    expect(hashed_response).to have_key("msg")
    expect(hashed_response["msg"]).to be_truthy
  end

  it "test update supplier endpoint PATCH/1 passing blank name parameter" do
    patch(
      '/1', 
      JSON.generate("name" => ""),
      'CONTENT_TYPE' => 'application/json'
    ) 
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(422) 
    expect(hashed_response).to have_key("msg")
    expect(hashed_response["msg"]).to be_truthy
  end

  it "test update supplier endpoint PATCH/1 passing a name of another supplier registerd" do
    patch(
      '/1', 
      JSON.generate("name" => "supplier 02"),
      'CONTENT_TYPE' => 'application/json'
    ) 
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(422) 
    expect(hashed_response).to have_key("msg")
    expect(hashed_response["msg"]).to be_truthy
  end

  it "test delete supplier by id endpoint DELETE/1" do
    delete '/1'
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(200) 
    expect(hashed_response).to have_key("msg")
    expect(hashed_response["msg"]).to be_truthy
  end

  it "test delete supplier by id endpoint DELETE/99" do
    delete '/99'
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(404) 
    expect(hashed_response).to have_key("msg")
    expect(hashed_response["msg"]).to be_truthy
  end

  
  
end
