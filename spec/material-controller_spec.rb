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

  it "test get material by id endpoint GET/1" do
    get '/1'
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(200) 
    expect(hashed_response).to have_key("material")
    expect(hashed_response["material"]).to be_truthy
  end

  it "test get material type by id endpoint GET/99" do
    get '/99'
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(404) 
    expect(hashed_response).to have_key("msg")
    expect(hashed_response["msg"]).to be_truthy
  end

  it "test create material endpoint" do
    post(
      '/', 
      JSON.generate("amount" => 999,
      "price" => 99,
      "description" => "Test description",
      "supplier_id" => 1,
      "material_type_id" => 2),
      'CONTENT_TYPE' => 'application/json'
    ) 
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(201) 
    expect(hashed_response).to have_key("material")
    expect(hashed_response["material"]).to be_truthy
  end

  it "test create material endpoint without passing supplier id" do
    post(
      '/', 
      JSON.generate("amount" => 999,
      "price" => 99,
      "description" => "Test description",
      "supplier_id" => "",
      "material_type_id" => 2),
      'CONTENT_TYPE' => 'application/json'
    ) 
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(422) 
    expect(hashed_response).to have_key("msg")
    expect(hashed_response["msg"]).to be_truthy
  end

  it "test create material endpoint passing invalid supplier id" do
    post(
      '/', 
      JSON.generate("amount" => 999,
      "price" => 99,
      "description" => "Test description",
      "supplier_id" => 99,
      "material_type_id" => 2),
      'CONTENT_TYPE' => 'application/json'
    ) 
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(422) 
    expect(hashed_response).to have_key("msg")
    expect(hashed_response["msg"]).to be_truthy
  end

  it "test create material endpoint without passing material type id" do
    post(
      '/', 
      JSON.generate("amount" => 999,
      "price" => 99,
      "description" => "Test description",
      "supplier_id" => 1,
      "material_type_id" => ""),
      'CONTENT_TYPE' => 'application/json'
    ) 
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(422) 
    expect(hashed_response).to have_key("msg")
    expect(hashed_response["msg"]).to be_truthy
  end

  it "test create material endpoint passing invalid material type id" do
    post(
      '/', 
      JSON.generate("amount" => 999,
      "price" => 99,
      "description" => "Test description",
      "supplier_id" => 1,
      "material_type_id" => 99),
      'CONTENT_TYPE' => 'application/json'
    ) 
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(422) 
    expect(hashed_response).to have_key("msg")
    expect(hashed_response["msg"]).to be_truthy
  end

  it "test create material with material type already registered to supplier" do
    post(
      '/', 
      JSON.generate("amount" => 999,
      "price" => 99,
      "description" => "Test description",
      "supplier_id" => 1,
      "material_type_id" => 1),
      'CONTENT_TYPE' => 'application/json'
    ) 
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(422) 
    expect(hashed_response).to have_key("msg")
    expect(hashed_response["msg"]).to be_truthy
  end
end
