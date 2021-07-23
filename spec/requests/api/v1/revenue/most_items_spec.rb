require 'rails_helper'

RSpec.describe 'revenue ' do

  describe '1) merchants with the most revenue ' do
    it 'merchants with the most revenue 1.1'  do
      merchant0 = Merchant.create!(name: "albert")
      merchant1 = Merchant.create!(name: "bob ")
      merchant2 = Merchant.create!(name: "cat")

      item0 = merchant0.items.create!(name: "zero", description: "more", unit_price: 5)
      item1 = merchant0.items.create!(name: "one", description: "thingy", unit_price: 103)
      item2 = merchant0.items.create!(name: "two", description: "dohicky", unit_price: 16780)

      customer = Customer.create!(first_name: "Abe", last_name: "Oldman")

      invoice1 = customer.invoices.create(status: 'shipped')
      invoice2 = customer.invoices.create(status: 'shipped')
      invoice3 = customer.invoices.create(status: 'shipped')
      invoice4 = customer.invoices.create(status: 'shipped')
      invoice5 = customer.invoices.create(status: 'shipped')
      invoice6 = customer.invoices.create(status: 'shipped')

      invoice_item1 = InvoiceItem.create!(item: item0, invoice: invoice1, quantity: 4, unit_price: 5)
      invoice_item2 = InvoiceItem.create!(item: item0, invoice: invoice1, quantity: 2, unit_price: 5)
      invoice_item3 = InvoiceItem.create!(item: item0, invoice: invoice2, quantity: 4, unit_price: 5)
      invoice_item4 = InvoiceItem.create!(item: item0, invoice: invoice2, quantity: 2, unit_price: 5)

      invoice_item5 = InvoiceItem.create!(item: item1, invoice: invoice5, quantity: 2, unit_price: 5)
      invoice_item6 = InvoiceItem.create!(item: item1, invoice: invoice5, quantity: 2, unit_price: 5)
      invoice_item7 = InvoiceItem.create!(item: item1, invoice: invoice6, quantity: 2, unit_price: 5)
      invoice_item8 = InvoiceItem.create!(item: item1, invoice: invoice6, quantity: 2, unit_price: 5)

      invoice_item9 = InvoiceItem.create!(item: item2, invoice: invoice3, quantity: 2, unit_price: 5)
      invoice_item10 = InvoiceItem.create!(item: item2, invoice: invoice4, quantity: 2, unit_price: 5)

      get "/api/v1/revenue/merchants?quantity=2"
      merchants = JSON.parse(response.body, symbolize_names: true)

      binding.pry

      # expect(item[:data].length).to eq(0)
      # expect(item[:data]).to eq([])

    end
  end




end
