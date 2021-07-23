require 'rails_helper'
RSpec.describe 'items merchant'  do

  it "(1)happy path" do

    merchant = Merchant.create(name: "my merchant name")
    item = merchant.items.create!(name: "one", description: "thingy", unit_price: 10)
    get "/api/v1/items/#{item.id}/merchant"
    merchant_return = JSON.parse(response.body, symbolize_names: true)


    expect(merchant_return[:data]).to have_key(:id)
    expect(merchant_return[:data][:id]).to eq(merchant.id.to_s)

    expect(merchant_return[:data][:attributes]).to have_key(:name)
    expect(merchant_return[:data][:attributes][:name]).to eq(merchant.name)
  end

  it "(2)sad path" do
    merchant = Merchant.create(name: "my merchant name")
    item = merchant.items.create!(name: "one", description: "thingy", unit_price: 10)
    get "/api/v1/items/#{item.id+1}/merchant"

    error = JSON.parse(response.body, symbolize_names: true)
    status = response.status

    expect(response.status).to eq(404)
    expect(error[:id]).to eq(nil)
    expect(error[:data]).to be_a(Hash)
    expect(error[:data][:message]).to eq("your query could not be completed")
    expect(error[:data][:errors]).to be_a(Array)
  end
end
