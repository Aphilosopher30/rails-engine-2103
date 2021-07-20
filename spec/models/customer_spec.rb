require 'rails_helper'

RSpec.describe Customer, type: :model do

  it { should have_many(:invoices) }
  it { should have_many(:invoice_items).through(:invoices) }
  it { should have_many(:items).through(:invoice_items) }
  it { should have_many(:merchants).through(:items) }
  it { should have_many(:transactions).through(:invoices) }
end
