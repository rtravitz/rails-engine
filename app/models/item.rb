class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, :description, :unit_price, presence: true

  def self.most_revenue(quantity = 5)
    Item.select("items.*, sum(invoice_items.quantity) * items.unit_price as total_price")
          .joins(:invoice_items)
          .joins(invoices: :transactions)
          .merge(Transaction.successful)
          .group(:id)
          .order("total_price DESC")
          .limit(quantity)
  end
end
