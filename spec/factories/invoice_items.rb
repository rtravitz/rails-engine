FactoryGirl.define do
  sequence :quantity do |n|
    n
  end

  factory :invoice_item do
    quantity
    unit_price 1
    item
    invoice
  end
end
