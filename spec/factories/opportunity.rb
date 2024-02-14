FactoryBot.define do
  
  factory :opportunity do
    
    status {"ongoing"}
    no_of_applications {Faker::Number.between(from: 1, to: 1000)}
    designation {"developer"}
    skillset {Faker::Lorem.sentence}
    package {Faker::Number.between(from:1.0, to: 100.0)}
    start_date {"13-02-2020"}
    end_date {"20-12-2024"}
    
  end
end