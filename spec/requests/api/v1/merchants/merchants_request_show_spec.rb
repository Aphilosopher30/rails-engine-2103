require 'rails_helper'

RSpec.describe 'merchant show' do

  describe "merchant show" do
    it 'happy path' do

      merchant_1 = Merchant.create(name: "random_marchant_1")
      merchant_2 = Merchant.create(name: "random_marchant_2")
      merchant_3 = Merchant.create(name: "random_marchant_3")
      merchant_4 = Merchant.create(name: "random_marchant_4")
      merchant_5 = Merchant.create(name: "random_marchant_5")

      get "/api/v1/merchants/#{merchant_3.id}"

      merchant_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful

      expect(merchant_response[:data]).to have_key(:id)
      expect(merchant_response[:data][:id]).to eq(merchant_3.id.to_s)
      expect(merchant_response[:data][:attributes][:name]).to be_a(String)
      expect(merchant_response[:data][:attributes]).to have_key(:name)
    end
  end

  describe 'sad paths' do
    it 'if we pass in an id that doesnt exit' do
      merchant_1 = Merchant.create(name: "random_marchant_1")
      merchant_2 = Merchant.create(name: "random_marchant_2")
      merchant_3 = Merchant.create(name: "random_marchant_3")

      not_an_id = merchant_1.id.to_i + merchant_2.id.to_i + merchant_3.id.to_i

      get "/api/v1/merchants/#{not_an_id}"


      # binding.pry

      status = response.status
      expect(response.status).to eq(404)

      # response = JSON.parse(response.body, symbolize_names: true)
      # expect(response).to eq(nil)
    end
  end
end
