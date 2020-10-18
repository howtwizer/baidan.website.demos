FactoryBot.define do
  factory :artist do
    display_name { Faker::Artist.name }
    nationality { Faker::Nation.nationality }
    sequence(:constituent_id) { |n| n }
  end
end
