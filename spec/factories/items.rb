FactoryGirl.define do
  sequence :name do |n|
    "ItemName#{n}"
  end

  sequence :description do |n|
    "Description#{n}"
  end

  sequence :unit_price do |n|
    n
  end

  factory :item do
    name
    description
    unit_price
    merchant
  end
end
