class Transaction < ApplicationRecord
  belongs_to :invoice
  validates :credit_card_number, :result, presence: true

  def self.random
    offset = rand(Transaction.count)
    rand_record = Transaction.offset(offset).first
  end

end
