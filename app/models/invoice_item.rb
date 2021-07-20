class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  has_many :merchants, through: :items
  has_many :transactions, through: :invoice
end
