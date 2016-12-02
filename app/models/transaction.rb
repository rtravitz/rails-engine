class Transaction < ApplicationRecord
  belongs_to :invoice
  validates :credit_card_number, :result, presence: true

  scope :successful, -> { where(result: 'success') }
end
