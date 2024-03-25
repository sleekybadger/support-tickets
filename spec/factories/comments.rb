FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.paragraph }
    ticket
  end
end
