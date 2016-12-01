class Invoice < ApplicationRecord
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :customer
  belongs_to :merchant

  validates :status, presence: true

  scope :successful_transaction, -> { 
    joins(:transactions)
    .where(transactions: {result: 'success'}) 
  }
end
