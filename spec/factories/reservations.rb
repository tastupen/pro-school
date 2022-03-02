FactoryBot.define do
  factory :reservation do
    user
    lesson
    admin
    start_time { "2022-02-12 01:52:34" }
  end
end
