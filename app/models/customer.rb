class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  validates :first_name, :last_name, presence: true

  def favorite_merchant
    merchants
    .select("merchants.*, count(invoices.id) as invoice_count")
    .joins(invoices: :transactions)
    .merge(Transaction.successful)
    .group("merchants.id")
    .order("invoice_count DESC")
    .first
  end
end
