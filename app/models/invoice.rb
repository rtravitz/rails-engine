class Invoice < ApplicationRecord
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :customer
  belongs_to :merchant

  validates :status, presence: true

  # def self.update_dates
  #   Invoice.update_all(created_at: :created_at)
  # end
end
