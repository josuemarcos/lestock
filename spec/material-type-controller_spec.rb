require 'dotenv'
require 'rack/test'
require_relative '../app/controllers/material-type-controller'

describe MaterialTypeController do
  include Rack::Test::Methods
 
  let(:app) {MaterialTypeController}

  before(:all) do
    require_relative '../config/environment'
  end
  
  it "test GET all material types" do
    get '/'
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(200)
    expect(hashed_response.length).to eq(3)
  end

  it "test GET material types using query string" do
    get '/?name=rock'
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(200) 
    expect(hashed_response.length).to eq(1)
  end

  it "test get material type by id endpoint GET/1" do
    get '/1'
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(200) 
    expect(hashed_response).to have_key("material_type")
    expect(hashed_response["material_type"]).to be_truthy
  end

  it "test get material type by id endpoint GET/99" do
    get '/99'
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(404) 
    expect(hashed_response).to have_key("msg")
    expect(hashed_response["msg"]).to be_truthy
  end

  it "test create material type endpoint" do
    post(
      '/', 
      JSON.generate("name" => "test material type",
      "metric_unit" => "test metric unit"),
      'CONTENT_TYPE' => 'application/json'
    ) 
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(201) 
    expect(hashed_response).to have_key("material_type")
    expect(hashed_response["material_type"]).to be_truthy
  end

  it "test create material type endpoint without passing name parameter" do
    post(
      '/', 
      JSON.generate("name" => "",
      "metric_unit" => "test metric unit"),
      'CONTENT_TYPE' => 'application/json'
    ) 
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(422) 
    expect(hashed_response).to have_key("msg")
    expect(hashed_response["msg"]).to be_truthy
  end
  
  it "test create material type endpoint passing a name already registered" do
    post(
      '/', 
      JSON.generate("name" => "cement",
      "metric_unit" => "test metric unit"),
      'CONTENT_TYPE' => 'application/json'
    ) 
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(422) 
    expect(hashed_response).to have_key("msg")
    expect(hashed_response["msg"]).to be_truthy
  end

  it "test update material type endpoint PATCH/1" do
    patch(
      '/1', 
      JSON.generate("name" => "test"),
      'CONTENT_TYPE' => 'application/json'
    ) 
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(200) 
    expect(hashed_response).to have_key("material_type")
    expect(hashed_response["material_type"]).to be_truthy
  end
  
  it "test update material type endpoint PATCH/99" do
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

  it "test update material type endpoint PATCH/1 passing blank name parameter" do
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

  it "test update material type endpoint PATCH/1 passing a name of another supplier registerd" do
    patch(
      '/1', 
      JSON.generate("name" => "glue"),
      'CONTENT_TYPE' => 'application/json'
    ) 
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(422) 
    expect(hashed_response).to have_key("msg")
    expect(hashed_response["msg"]).to be_truthy
  end

  it "test delete material type by id endpoint DELETE/1" do
    delete '/1'
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(200) 
    expect(hashed_response).to have_key("msg")
    expect(hashed_response["msg"]).to be_truthy
  end

  it "test delete material type by id endpoint DELETE/99" do
    delete '/99'
    hashed_response = JSON.parse(last_response.body)
    expect(last_response.status).to eq(404) 
    expect(hashed_response).to have_key("msg")
    expect(hashed_response["msg"]).to be_truthy
  end

end
