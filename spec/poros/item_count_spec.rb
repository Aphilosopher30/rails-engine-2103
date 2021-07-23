require 'rails_helper'

RSpec.describe 'item count poro'  do

  it "it exists with atributes" do

    merchant = Merchant.create!(name: "alber")
    test = ItemCount.new(merchant.id, 356.5)

    expect(test.id).to eq(merchant.id)
    expect(test.name).to eq(merchant.name)
    expect(test.count).to eq(356.5)
  end

  it 'revenue defaults to 0 if it is passed nil' do

    merchant_1 = Merchant.create!(name: "alber")
    revenue_object = ItemCount.new(merchant_1.id, nil)

    expect(revenue_object.count).to eq(0)
  end

end
