FactoryBot.define do
  factory :artwork do
    title { Faker::Book.title }
    sequence(:accession_number) { |n| "#{n}.#{n+Random.new.rand(1000)}.#{n+Random.new.rand(1000)}"}
    artist
    classification
    department
  end
end
