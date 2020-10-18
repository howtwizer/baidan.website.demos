FactoryBot.define do
  factory :classification do
    title { Faker::Book.genre }
  end
end
