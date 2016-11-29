class Customer < ApplicationRecord
  has_many :invoices
  validates :first_name, :last_name, presence: true

  def self.random
    offset = rand(Customer.count)
    rand_record = Customer.offset(offset).first
  end

end
