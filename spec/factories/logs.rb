FactoryBot.define do
  factory :log do
    message {Faker::Lorem.paragraph}
  end
end
