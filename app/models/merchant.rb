class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items

  validates :name, presence: true

  def total_revenue
    {"revenue" =>
      to_float(invoices
              .joins(:transactions)
              .joins(:invoice_items)
              .where("transactions.result = 'success'" )
              .sum("invoice_items.quantity * invoice_items.unit_price"))}
  end

  def to_float(input)
     "#{'%.2f' % (input/100.0)}"
  end
end
