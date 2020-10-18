FactoryBot.define do
  factory :department do
    title { Faker::Book.publisher }
  end
end
