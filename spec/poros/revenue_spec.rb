# require 'rails_helper'
#
# RSpec.describe 'revenue poro'  do
#
#   it "it exists with atributes" do
#
#     merchant = Merchant.create!(name: "alber")
#     test = Revenue.new(merchant.id, 356.5)
#
#     expect(test.id).to eq(merchant.id)
#     expect(test.name).to eq(merchant.name)
#     expect(test.revenue).to eq(356.5)
#   end
#
#   it 'revenue defaults to 0 if it is passed nil' do
#
#     merchant_1 = Merchant.create!(name: "alber")
#     revenue_object = Revenue.new(merchant_1.id, nil)
#
#     expect(revenue_object.revenue).to eq(0)
#   end
# #
# end
