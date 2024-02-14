FactoryBot.define do
  
  factory :company do
    name {Faker::Company.name}
    information {Faker::Lorem.sentence}
    website {Faker::Internet.url}
  end

  

end