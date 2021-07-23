require 'rails_helper'
RSpec.describe 'items index '  do

  describe "(1) get all items (item index)" do
    describe "(1.1) happy path" do
      it "(1.1.1)it can get all  items " do
        merchant0 = Merchant.create!(name: "alber")
        merchant1 = Merchant.create!(name: "bob ")
        merchant2 = Merchant.create!(name: "cat")
        merchant3 = Merchant.create!(name: "dog")

        item0 = merchant0.items.create!(name: "zero", description: "more", unit_price: 10)
        item1 = merchant0.items.create!(name: "one", description: "thingy", unit_price: 10)
        item2 = merchant0.items.create!(name: "two", description: "dohicky", unit_price: 10)
        item3 = merchant0.items.create!(name: "three", description: "stuff", unit_price: 10)
        item10 = merchant1.items.create!(name: "ten", description: "more", unit_price: 10)
        item11 = merchant1.items.create!(name: "eleven", description: "thingy", unit_price: 10)
        item12 = merchant1.items.create!(name: "twelve", description: "thingy", unit_price: 10)
        item13 = merchant1.items.create!(name: "thirteen", description: "thingy", unit_price: 10)
        item20 = merchant2.items.create!(name: "twenty one", description: "thingy", unit_price: 10)
        item21 = merchant2.items.create!(name: "twenty two", description: "thingy", unit_price: 10)
        item22 = merchant2.items.create!(name: "twenty three", description: "thingy", unit_price: 10)
        item23 = merchant2.items.create!(name: "twenty four", description: "thingy", unit_price: 10)

        get '/api/v1/items'
        items = JSON.parse(response.body)

        expect(items["data"].length).to eq(12)
      end

      describe '(1.1.2)can show one page at a time' do
        it '(1.1.2.1)first page ' do
          merchant0 = Merchant.create!(name: "alber")
          merchant1 = Merchant.create!(name: "bob ")
          merchant2 = Merchant.create!(name: "cat")
          merchant3 = Merchant.create!(name: "dog")

          item0 = merchant0.items.create!(name: "zero", description: "more", unit_price: 10)
          item1 = merchant0.items.create!(name: "one", description: "thingy", unit_price: 10)
          item2 = merchant0.items.create!(name: "two", description: "dohicky", unit_price: 10)
          item3 = merchant0.items.create!(name: "three", description: "stuff", unit_price: 10)
          item10 = merchant1.items.create!(name: "ten", description: "more", unit_price: 10)
          item11 = merchant1.items.create!(name: "eleven", description: "thingy", unit_price: 10)
          item12 = merchant1.items.create!(name: "twelve", description: "thingy", unit_price: 10)
          item13 = merchant1.items.create!(name: "thirteen", description: "thingy", unit_price: 10)
          item20 = merchant2.items.create!(name: "twenty one", description: "thingy", unit_price: 10)
          item21 = merchant2.items.create!(name: "twenty two", description: "thingy", unit_price: 10)
          item22 = merchant2.items.create!(name: "twenty three", description: "thingy", unit_price: 10)
          item23 = merchant2.items.create!(name: "twenty four", description: "thingy", unit_price: 10)

          get '/api/v1/items?page=1&per_page=5'
          items = JSON.parse(response.body)

          expect(items["data"].length).to eq(5)
        end

        it '(1.1.2.2)second page' do
          merchant0 = Merchant.create!(name: "alber")
          merchant1 = Merchant.create!(name: "bob ")
          merchant2 = Merchant.create!(name: "cat")
          merchant3 = Merchant.create!(name: "dog")

          item0 = merchant0.items.create!(name: "zero", description: "more", unit_price: 10)
          item1 = merchant0.items.create!(name: "one", description: "thingy", unit_price: 10)
          item2 = merchant0.items.create!(name: "two", description: "dohicky", unit_price: 10)
          item3 = merchant0.items.create!(name: "three", description: "stuff", unit_price: 10)
          item10 = merchant1.items.create!(name: "ten", description: "more", unit_price: 10)
          item11 = merchant1.items.create!(name: "eleven", description: "thingy", unit_price: 10)
          item12 = merchant1.items.create!(name: "twelve", description: "thingy", unit_price: 10)
          item13 = merchant1.items.create!(name: "thirteen", description: "thingy", unit_price: 10)
          item20 = merchant2.items.create!(name: "twenty one", description: "thingy", unit_price: 10)
          item21 = merchant2.items.create!(name: "twenty two", description: "thingy", unit_price: 10)
          item22 = merchant2.items.create!(name: "twenty three", description: "thingy", unit_price: 10)
          item23 = merchant2.items.create!(name: "twenty four", description: "thingy", unit_price: 10)

          get '/api/v1/items?page=2&per_page=5'
          items = JSON.parse(response.body)

          expect(items["data"].length).to eq(5)
          expect(items["data"].first["id"]).to eq(item11.id.to_s)
        end

        it '(1.1.2.3)last page can be extra short' do
          merchant0 = Merchant.create!(name: "alber")
          merchant1 = Merchant.create!(name: "bob ")
          merchant2 = Merchant.create!(name: "cat")
          merchant3 = Merchant.create!(name: "dog")

          item0 = merchant0.items.create!(name: "zero", description: "more", unit_price: 10)
          item1 = merchant0.items.create!(name: "one", description: "thingy", unit_price: 10)
          item2 = merchant0.items.create!(name: "two", description: "dohicky", unit_price: 10)
          item3 = merchant0.items.create!(name: "three", description: "stuff", unit_price: 10)
          item10 = merchant1.items.create!(name: "ten", description: "more", unit_price: 10)
          item11 = merchant1.items.create!(name: "eleven", description: "thingy", unit_price: 10)
          item12 = merchant1.items.create!(name: "twelve", description: "thingy", unit_price: 10)
          item13 = merchant1.items.create!(name: "thirteen", description: "thingy", unit_price: 10)
          item20 = merchant2.items.create!(name: "twenty one", description: "thingy", unit_price: 10)
          item21 = merchant2.items.create!(name: "twenty two", description: "thingy", unit_price: 10)
          item22 = merchant2.items.create!(name: "twenty three", description: "thingy", unit_price: 10)
          item23 = merchant2.items.create!(name: "twenty four", description: "thingy", unit_price: 10)

          get '/api/v1/items?page=3&per_page=5'
          items = JSON.parse(response.body)

          expect(items["data"].length).to eq(2)
        end

        it '(1.1.2.4) page number less than 1 returns page 1' do
          merchant0 = Merchant.create!(name: "alber")
          merchant1 = Merchant.create!(name: "bob ")
          merchant2 = Merchant.create!(name: "cat")
          merchant3 = Merchant.create!(name: "dog")

          item0 = merchant0.items.create!(name: "zero", description: "more", unit_price: 10)
          item1 = merchant0.items.create!(name: "one", description: "thingy", unit_price: 10)
          item2 = merchant0.items.create!(name: "two", description: "dohicky", unit_price: 10)
          item3 = merchant0.items.create!(name: "three", description: "stuff", unit_price: 10)
          item10 = merchant1.items.create!(name: "ten", description: "more", unit_price: 10)
          item11 = merchant1.items.create!(name: "eleven", description: "thingy", unit_price: 10)
          item12 = merchant1.items.create!(name: "twelve", description: "thingy", unit_price: 10)
          item13 = merchant1.items.create!(name: "thirteen", description: "thingy", unit_price: 10)
          item20 = merchant2.items.create!(name: "twenty one", description: "thingy", unit_price: 10)
          item21 = merchant2.items.create!(name: "twenty two", description: "thingy", unit_price: 10)
          item22 = merchant2.items.create!(name: "twenty three", description: "thingy", unit_price: 10)
          item23 = merchant2.items.create!(name: "twenty four", description: "thingy", unit_price: 10)

          first_item = Item.all.first
          last_item = Item.all[9]

          get '/api/v1/items?page=0&per_page=10'
          item = JSON.parse(response.body)

          expect(item["data"].first['id']).to eq(first_item.id.to_s)
          expect(item["data"].last['id']).to eq(last_item.id.to_s)
        end
      end
    end

    describe "(1.2) sad path" do
    end
  end
end
