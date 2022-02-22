FactoryBot.define do
  factory :reservation do
    association :user
    association :lesson
    association :admin
    start_time { "2022-02-12 01:52:34" }
  end
end
