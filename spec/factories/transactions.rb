FactoryGirl.define do
  factory :transaction do
    credit_card_number
    credit_card_expiration_date "2016-11-28"
    result
    invoice
  end

  sequence :credit_card_number do |n|
    n
  end

  sequence :result do |n|
    "TransactionResult#{n}"
  end
end
