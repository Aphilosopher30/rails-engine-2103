require 'rails_helper'

RSpec.describe 'merchant requests' do
  describe "mechant index " do
    describe 'happy path' do
      it "returns an array, and each item in the array is a merchant" do
        create_list(:merchant, 10)

        get '/api/v1/merchants'

        expect(response).to be_successful

        merchants = JSON.parse(response.body)

        expect(merchants[:data].length).to eq(10)

        expect(merchants[:data][0]).to be_a(Hash)
        expect(merchants[:data][0]).to have_key(:id)
        expect(merchants[:data][0][:id]).to be_a(String)
        expect(merchants[:data][0]).to have_key(:name)
        expect(merchants[:data][0][:attributes][:name]).to be_a(String)

        expect(merchants[:data][-1]).to be_a(Hash)
        expect(merchants[:data][-1]).to have_key(:id)
        expect(merchants[:data][-1][:id]).to be_a(String)
        expect(merchants[:data][-1]).to have_key(:name)
        expect(merchants[:data][-1][:attributes][:name]).to be_a(String)
      end

      it "20 merchants on fist page" do
        create_list(:merchant, 50)

        get '/api/v1/merchants?page=1'
        merchants = JSON.parse(response.body)

        expect(merchants[:data].length).to eq(20)
      end

      it "20 merchants on second page" do
        create_list(:merchant, 50)

        get '/api/v1/merchants?page=2'
        merchants = JSON.parse(response.body)

        expect(merchants[:data].length).to eq(20)
      end


      it "the last page can have fewer than 20 merchants" do
        create_list(:merchant, 50)

        get '/api/v1/merchants?page=3'
        merchants = JSON.parse(response.body)

        expect(merchants[:data].length).to eq(20)
      end
    end
  end
end