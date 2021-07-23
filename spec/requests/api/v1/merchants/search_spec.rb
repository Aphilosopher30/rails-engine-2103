require 'rails_helper'
RSpec.describe 'merchant search'  do

  describe "find_all" do
    it "get all merchants alphabetically sorted" do
      merchant1 = Merchant.create(name: "my merchant name")
      merchant2 = Merchant.create(name: "seller of stuff nomber 2")
      merchant3 = Merchant.create(name: "merch 3")


      get "/api/v1/merchants/find_all?name=merch"

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data].length).to eq(2)

      expect(merchant[:data][0][:attributes]).to have_key(:name)
      expect(merchant[:data][0][:attributes][:name]).to eq(merchant3.name)
      expect(merchant[:data][1][:attributes]).to have_key(:name)
      expect(merchant[:data][1][:attributes][:name]).to eq(merchant1.name)
    end
  end

  describe "find" do
    it "gets exact match when available " do
      merchant1 = Merchant.create(name: "my merchant name")
      merchant2 = Merchant.create(name: "seller of stuff nomber 2")
      merchant4 = Merchant.create(name: "merch")
      merchant3 = Merchant.create(name: "merch 3")


      get "/api/v1/merchants/find?name=merch"

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data][:id]).to eq(merchant4.id.to_s)
      expect(merchant[:data]).to have_key(:type)
      expect(merchant[:data][:type]).to eq("merchant")

      expect(merchant[:data]).to have_key(:attributes)
      expect(merchant[:data][:attributes][:name]).to eq(merchant4.name)
    end

    it "first result when no exact match " do
      merchant1 = Merchant.create(name: "my merchant name")
      merchant2 = Merchant.create(name: "tile flor seller")
      merchant3 = Merchant.create(name: "merchantile")
      merchant4 = Merchant.create(name: "merch 3")


      get "/api/v1/merchants/find?name=tile"

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data][:id]).to eq(merchant2.id.to_s)
      expect(merchant[:data]).to have_key(:type)
      expect(merchant[:data][:type]).to eq("merchant")

      expect(merchant[:data]).to have_key(:attributes)
      expect(merchant[:data][:attributes][:name]).to eq(merchant2.name)
    end


    it "gets exact match when available " do
      merchant1 = Merchant.create(name: "my merchant name")
      merchant2 = Merchant.create(name: "seller of stuff nomber 2")
      merchant4 = Merchant.create(name: "merch")
      merchant3 = Merchant.create(name: "merch 3")


      get "/api/v1/merchants/find"

      merchant = JSON.parse(response.body, symbolize_names: true)

      respone_value = JSON.parse(response.body, symbolize_names: true)
      status = response.status

      expect(response.status).to eq(404)
      expect(respone_value[:id]).to eq(nil)
      expect(respone_value[:data]).to be_a(Hash)
      expect(respone_value[:data][:message]).to eq("your query could not be completed")
      expect(respone_value[:data][:errors]).to eq(["no name provided for the search"])
    end


    it "returns message if noresults  matches name" do
      merchant1 = Merchant.create(name: "my merchant name")
      merchant2 = Merchant.create(name: "merch two")


      get "/api/v1/merchants/find?name=asdfaksdjfkasjhdfkalsjfkhdsl"

      respone_value = JSON.parse(response.body, symbolize_names: true)
      status = response.status

      expect(response.status).to eq(200)
      expect(respone_value[:id]).to eq(nil)
      expect(respone_value[:data]).to be_a(Hash)
      expect(respone_value[:data][:message]).to eq("no merchants found")
    end
  end


end
