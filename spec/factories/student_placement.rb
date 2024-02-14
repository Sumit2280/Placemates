FactoryBot.define do
  factory :student_placement do
    designation {Faker::Lorem.sentence}
    package {Faker::Number.between(from: 1.0, to: 100.0)}
    requirements {Faker::Lorem.sentence}
  end
end