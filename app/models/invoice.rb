class Invoice < ApplicationRecord
  has_many :transactions
  belongs_to :customer
  belongs_to :merchant

  validates :status, presence: true

  def self.random
    offset = rand(Invoice.count)
    rand_record = Invoice.offset(offset).first
  end

end
