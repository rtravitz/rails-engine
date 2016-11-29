class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  validates :name, presence: true

  def self.random
    offset = rand(Merchant.count)
    rand_record = Merchant.offset(offset).first
  end
  
end
