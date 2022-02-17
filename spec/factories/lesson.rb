FactoryBot.define do
  factory :lesson do
    name                  {"クロール"}
    description           {"初級コース"}
    price                 {"5000"}
    association :category
    association :admin
  end
end