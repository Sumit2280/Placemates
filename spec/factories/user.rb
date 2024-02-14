FactoryBot.define do
  factory :user do
    # role_id {1}
    email {"iamsumit@gmail.com"}
    password {Faker::Internet.password}
    first_name {"Sumit"}
    last_name {"Done"}
    branch {"Computer"}
    batch {2023}
    placed {false}
    linkedin {Faker::Internet.url}
  end
end