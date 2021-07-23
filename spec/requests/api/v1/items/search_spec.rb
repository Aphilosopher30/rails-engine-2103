require 'rails_helper'
RSpec.describe 'search'  do

#
  it "get all items" do
    merchant1 = Merchant.create(name: "my merchant name")
    merchant2 = Merchant.create(name: "merch two")

    item0 = merchant2.items.create!(name: "eno", description: "dohicky", unit_price: 2)
    item1 = merchant1.items.create!(name: "a three  one", description: "stuff", unit_price: 3)
    item2 = merchant1.items.create!(name: "b one ", description: "stuff", unit_price: 3)
    item3 = merchant2.items.create!(name: "woneone ", description: "stuff", unit_price: 3)


    get "/api/v1/items/find_all?name=one"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data].length).to eq(3)

    expect(item[:data][0][:attributes]).to have_key(:name)
    expect(item[:data][0][:attributes][:name]).to eq(item1.name)
    expect(item[:data][1][:attributes]).to have_key(:name)
    expect(item[:data][1][:attributes][:name]).to eq(item2.name)
    expect(item[:data][2][:attributes]).to have_key(:name)
    expect(item[:data][2][:attributes][:name]).to eq(item3.name)
  end

  it "get all items is sorted alphabetically" do
    merchant1 = Merchant.create(name: "my merchant name")
    merchant2 = Merchant.create(name: "merch two")

    item2 = merchant2.items.create!(name: "eno", description: "dohicky", unit_price: 2)
    item3 = merchant1.items.create!(name: "three  one", description: "stuff", unit_price: 3)
    item1 = merchant1.items.create!(name: "one ", description: "stuff", unit_price: 3)
    item0 = merchant2.items.create!(name: "woneone ", description: "stuff", unit_price: 3)


    get "/api/v1/items/find_all?name=one"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data].length).to eq(3)

    expect(item[:data][0][:attributes]).to have_key(:name)
    expect(item[:data][0][:attributes][:name]).to eq(item1.name)
    expect(item[:data][1][:attributes]).to have_key(:name)
    expect(item[:data][1][:attributes][:name]).to eq(item3.name)
    expect(item[:data][2][:attributes]).to have_key(:name)
    expect(item[:data][2][:attributes][:name]).to eq(item0.name)
  end

  it "gets exact match when available " do
    merchant1 = Merchant.create(name: "my merchant name")
    merchant2 = Merchant.create(name: "merch two")

    item2 = merchant2.items.create!(name: "eno", description: "dohicky", unit_price: 2)
    item3 = merchant1.items.create!(name: "three one", description: "stuff", unit_price: 3)
    item1 = merchant1.items.create!(name: "one", description: "stuff", unit_price: 3)
    item0 = merchant2.items.create!(name: "oneone ", description: "stuff", unit_price: 3)


    get "/api/v1/items/find?name=one"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to eq(item1.id.to_s)
    expect(item[:data]).to have_key(:type)
    expect(item[:data][:type]).to eq("item")

    expect(item[:data]).to have_key(:attributes)
    expect(item[:data][:attributes][:name]).to eq(item1.name)
  end

  it "returns message if no matches name" do
    merchant1 = Merchant.create(name: "my merchant name")
    merchant2 = Merchant.create(name: "merch two")

    item2 = merchant2.items.create!(name: "eno", description: "dohicky", unit_price: 2)
    item3 = merchant1.items.create!(name: "three  one", description: "stuff", unit_price: 3)
    item1 = merchant1.items.create!(name: "one ", description: "stuff", unit_price: 3)
    item0 = merchant2.items.create!(name: "woneone ", description: "stuff", unit_price: 3)

    get "/api/v1/items/find?name=asdfaksdjfkasjhdfkalsjfkhdsl"

    respone_value = JSON.parse(response.body, symbolize_names: true)
    status = response.status

    expect(response.status).to eq(200)
    expect(respone_value[:id]).to eq(nil)
    expect(respone_value[:data]).to be_a(Hash)
    expect(respone_value[:data][:message]).to eq("no items found")
  end


end
