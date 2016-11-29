FactoryGirl.define do
  sequence :status do |n|
    "status#{n}"
  end

  factory :invoice do
    status
    customer
    merchant
  end
end
