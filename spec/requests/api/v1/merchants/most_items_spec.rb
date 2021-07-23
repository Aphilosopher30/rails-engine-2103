require 'rails_helper'

RSpec.describe 'merchant top sellers ' do

  describe ' merchants most items  ' do
    it 'gets  all if quantity is too big '  do

      merchant0 = Merchant.create(name: "albert")
      merchant1 = Merchant.create(name: "bob ")
      merchant2 = Merchant.create(name: "cat")

      item1 = merchant1.items.create!(name: "one", description: "thingy", unit_price: 103)
      item2 = merchant2.items.create!(name: "two", description: "dohicky", unit_price: 16780)
      item0 = merchant0.items.create!(name: "zero", description: "more", unit_price: 5)

      customer = Customer.create!(first_name: "Abe", last_name: "Oldman")

      invoice1 = customer.invoices.create(status: 'shipped')
      invoice2 = customer.invoices.create(status: 'shipped')
      invoice3 = customer.invoices.create(status: 'shipped')
      invoice4 = customer.invoices.create(status: 'shipped')
      invoice5 = customer.invoices.create(status: 'shipped')
      invoice6 = customer.invoices.create(status: 'shipped')

      transactions = invoice1.transactions.create!(result: 'success', credit_card_number: 12345, credit_card_expiration_date: "12/12")
      transactions = invoice2.transactions.create!(result: 'success', credit_card_number: 12345, credit_card_expiration_date: "12/12")
      transactions = invoice3.transactions.create!(result: 'success', credit_card_number: 12345, credit_card_expiration_date: "12/12")
      transactions = invoice4.transactions.create!(result: 'success', credit_card_number: 12345, credit_card_expiration_date: "12/12")
      transactions = invoice5.transactions.create!(result: 'success', credit_card_number: 12345, credit_card_expiration_date: "12/12")
      transactions = invoice6.transactions.create!(result: 'success', credit_card_number: 12345, credit_card_expiration_date: "12/12")

      invoice_item1 = InvoiceItem.create!(item: item0, invoice: invoice1, quantity: 4, unit_price: 5)
      invoice_item2 = InvoiceItem.create!(item: item0, invoice: invoice1, quantity: 2, unit_price: 5)
      invoice_item3 = InvoiceItem.create!(item: item0, invoice: invoice2, quantity: 4, unit_price: 5)
      invoice_item4 = InvoiceItem.create!(item: item0, invoice: invoice2, quantity: 2, unit_price: 5)

      invoice_item5 = InvoiceItem.create!(item: item1, invoice: invoice5, quantity: 2, unit_price: 5)
      invoice_item6 = InvoiceItem.create!(item: item1, invoice: invoice5, quantity: 2, unit_price: 5)
      invoice_item7 = InvoiceItem.create!(item: item1, invoice: invoice6, quantity: 2, unit_price: 5)
      invoice_item8 = InvoiceItem.create!(item: item1, invoice: invoice6, quantity: 2, unit_price: 5)

      invoice_item9 = InvoiceItem.create!(item: item2, invoice: invoice3, quantity: 3, unit_price: 5)
      invoice_item10 = InvoiceItem.create!(item: item2, invoice: invoice4, quantity: 2, unit_price: 5)


      get "/api/v1/merchants/most_items?quantity=20"
      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].count).to eq(3)
    end

    it 'it can limit the number of responces returned '  do

      merchant0 = Merchant.create(name: "albert")
      merchant1 = Merchant.create(name: "bob ")
      merchant2 = Merchant.create(name: "cat")

      item1 = merchant1.items.create!(name: "one", description: "thingy", unit_price: 103)
      item2 = merchant2.items.create!(name: "two", description: "dohicky", unit_price: 16780)
      item0 = merchant0.items.create!(name: "zero", description: "more", unit_price: 5)

      customer = Customer.create!(first_name: "Abe", last_name: "Oldman")

      invoice1 = customer.invoices.create(status: 'shipped')
      invoice2 = customer.invoices.create(status: 'shipped')
      invoice3 = customer.invoices.create(status: 'shipped')
      invoice4 = customer.invoices.create(status: 'shipped')
      invoice5 = customer.invoices.create(status: 'shipped')
      invoice6 = customer.invoices.create(status: 'shipped')

      transactions = invoice1.transactions.create!(result: 'success', credit_card_number: 12345, credit_card_expiration_date: "12/12")
      transactions = invoice2.transactions.create!(result: 'success', credit_card_number: 12345, credit_card_expiration_date: "12/12")
      transactions = invoice3.transactions.create!(result: 'success', credit_card_number: 12345, credit_card_expiration_date: "12/12")
      transactions = invoice4.transactions.create!(result: 'success', credit_card_number: 12345, credit_card_expiration_date: "12/12")
      transactions = invoice5.transactions.create!(result: 'success', credit_card_number: 12345, credit_card_expiration_date: "12/12")
      transactions = invoice6.transactions.create!(result: 'success', credit_card_number: 12345, credit_card_expiration_date: "12/12")

      invoice_item1 = InvoiceItem.create!(item: item0, invoice: invoice1, quantity: 4, unit_price: 5)
      invoice_item2 = InvoiceItem.create!(item: item0, invoice: invoice1, quantity: 2, unit_price: 5)
      invoice_item3 = InvoiceItem.create!(item: item0, invoice: invoice2, quantity: 4, unit_price: 5)
      invoice_item4 = InvoiceItem.create!(item: item0, invoice: invoice2, quantity: 2, unit_price: 5)

      invoice_item5 = InvoiceItem.create!(item: item1, invoice: invoice5, quantity: 2, unit_price: 5)
      invoice_item6 = InvoiceItem.create!(item: item1, invoice: invoice5, quantity: 2, unit_price: 5)
      invoice_item7 = InvoiceItem.create!(item: item1, invoice: invoice6, quantity: 2, unit_price: 5)
      invoice_item8 = InvoiceItem.create!(item: item1, invoice: invoice6, quantity: 2, unit_price: 5)

      invoice_item9 = InvoiceItem.create!(item: item2, invoice: invoice3, quantity: 3, unit_price: 5)
      invoice_item10 = InvoiceItem.create!(item: item2, invoice: invoice4, quantity: 2, unit_price: 5)


      get "/api/v1/merchants/most_items?quantity=2"
      merchants = JSON.parse(response.body, symbolize_names: true)
# binding.pry
      expect(merchants[:data].count).to eq(2)
    end
  end

  it 'it can limit the number of responces returned '  do

    merchant0 = Merchant.create(name: "albert")
    merchant1 = Merchant.create(name: "bob ")
    merchant2 = Merchant.create(name: "cat")

    item1 = merchant1.items.create!(name: "one", description: "thingy", unit_price: 103)
    item2 = merchant2.items.create!(name: "two", description: "dohicky", unit_price: 16780)
    item0 = merchant0.items.create!(name: "zero", description: "more", unit_price: 5)

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

    invoice_item9 = InvoiceItem.create!(item: item2, invoice: invoice3, quantity: 3, unit_price: 5)
    invoice_item10 = InvoiceItem.create!(item: item2, invoice: invoice4, quantity: 2, unit_price: 5)


    transactions = invoice1.transactions.create!(result: 'success', credit_card_number: 12345, credit_card_expiration_date: "12/12")
    transactions = invoice2.transactions.create!(result: 'success', credit_card_number: 12345, credit_card_expiration_date: "12/12")
    transactions = invoice3.transactions.create!(result: 'success', credit_card_number: 12345, credit_card_expiration_date: "12/12")
    transactions = invoice4.transactions.create!(result: 'success', credit_card_number: 12345, credit_card_expiration_date: "12/12")
    transactions = invoice5.transactions.create!(result: 'success', credit_card_number: 12345, credit_card_expiration_date: "12/12")
    transactions = invoice6.transactions.create!(result: 'success', credit_card_number: 12345, credit_card_expiration_date: "12/12")


    get "/api/v1/merchants/most_items?"
    error = JSON.parse(response.body, symbolize_names: true)
# binding.pry
    expect(error[:id]).to eq(nil)
    expect(error[:data][:message]).to eq("invalid quantity")
    expect(error[:error]).to eq("invalid quantity")
  end



end
