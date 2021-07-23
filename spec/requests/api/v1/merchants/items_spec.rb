require 'rails_helper'

RSpec.describe 'merchant items' do

  describe '1) happy path ' do
    it 'returns all items belonging to a specific merchant 1.1'  do
      merchant0 = Merchant.create!(name: "albert")
      merchant1 = Merchant.create!(name: "bob ")
      merchant2 = Merchant.create!(name: "cat")
      item0 = merchant0.items.create!(name: "zero", description: "more", unit_price: 5)
      item1 = merchant0.items.create!(name: "one", description: "thingy", unit_price: 103)
      item2 = merchant0.items.create!(name: "two", description: "dohicky", unit_price: 16780)
      item3 = merchant0.items.create!(name: "three", description: "stuff", unit_price: 9)
      item10 = merchant1.items.create!(name: "ten", description: "more", unit_price: 10)
      item11 = merchant1.items.create!(name: "eleven", description: "thingy", unit_price: 20)
      item12 = merchant1.items.create!(name: "twelve", description: "doodle", unit_price: 30)
      item20 = merchant2.items.create!(name: "twenty", description: "greee", unit_price: 6)

      get "/api/v1/merchants/#{merchant1.id}/items"
      item = JSON.parse(response.body, symbolize_names: true)

      expect(item[:data].length).to eq(3)

      expect(item[:data][0][:id]).to eq(item10.id.to_s)
      expect(item[:data][0][:attributes][:name]).to eq(item10.name)
      expect(item[:data][0][:attributes][:description]).to eq(item10.description)
      expect(item[:data][0][:attributes][:unit_price]).to eq(item10.unit_price)

      expect(item[:data][1][:id]).to eq(item11.id.to_s)
      expect(item[:data][1][:attributes][:name]).to eq(item11.name)
      expect(item[:data][1][:attributes][:description]).to eq(item11.description)
      expect(item[:data][1][:attributes][:unit_price]).to eq(item11.unit_price)

      expect(item[:data][2][:id]).to eq(item12.id.to_s)
      expect(item[:data][2][:attributes][:name]).to eq(item12.name)
      expect(item[:data][2][:attributes][:description]).to eq(item12.description)
      expect(item[:data][2][:attributes][:unit_price]).to eq(item12.unit_price)


    end
    it 'it returns empty array if  no items belong to a merchant'  do



      merchant1 = Merchant.create!(name: "albert")

      get "/api/v1/merchants/#{merchant1.id}/items"
      item = JSON.parse(response.body, symbolize_names: true)

      expect(item[:data].length).to eq(0)
      expect(item[:data]).to eq([])
    end


  end

  describe '2) sad path ' do
    it 'returns a 404 response' do
      merchant1 = Merchant.create!(name: "albert")

      item0 = merchant1.items.create!(name: "zero", description: "more", unit_price: 5)
      item1 = merchant1.items.create!(name: "one", description: "thingy", unit_price: 103)

      get "/api/v1/merchants/#{merchant1.id+1}/items"

      error = JSON.parse(response.body, symbolize_names: true)

      status = response.status
      expect(response.status).to eq(404)

      expect(error[:id]).to eq(nil)
      expect(error[:data]).to be_a(Hash)
      expect(error[:data][:message]).to eq("your query could not be completed")
      expect(error[:data][:errors]).to be_a(Array)
    end
  end

end
