FactoryGirl.define do
  factory :customer do
    first_name
    last_name
  end
  
  sequence :first_name do |n|
    "CustomerFirstName#{n}"
  end

  sequence :last_name do |n|
    "CustomerLastName#{n}"
  end

end
