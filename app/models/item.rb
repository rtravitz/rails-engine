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
    Item.select("items.*")
    .joins(:invoice_items)
    .order("invoice_items.quantity")
    .limit(quantity)
  end
end
