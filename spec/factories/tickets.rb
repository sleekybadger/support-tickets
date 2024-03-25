FactoryBot.define do
  factory :ticket do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    status { Ticket::NEW }
    subject { Faker::Lorem.word }
    content { Faker::Lorem.paragraph }

    trait :pending do
      status { Ticket::PENDING }
    end

    trait :resolved do
      status { Ticket::RESOLVED }
    end
  end
end
