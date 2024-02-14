FactoryBot.define do
  factory :company_placement do
    year {"2020"}
    applied {Faker::Number.between(from: 1, to: 1000)}
    selected {Faker::Number.between(from: 1, to: 100)}
  end
end