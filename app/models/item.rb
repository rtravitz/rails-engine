class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, :description, :unit_price, presence: true

  def best_day
    {
      "best_day": invoices
                  .joins(:invoice_items)
                  .order("invoice_items.quantity DESC, invoices.created_at DESC")
                  .first
                  .created_at
    }
  end

  def self.most_items_sold(quantity)
    joins(:invoice_items)
    .joins(invoices: :transactions)
    .merge(Transaction.successful)
    .group("items.id")
    .order("sum(invoice_items.quantity)")
    .first(quantity)
  end
end
