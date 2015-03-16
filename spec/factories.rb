FactoryGirl.define do
  sequence :name do |n|
    "Person#{n}"
  end

  factory :item do
    name
    description  "Just a simple description..."
  end
end
