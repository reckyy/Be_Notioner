FactoryBot.define do
  factory :user do
    name { 'test' }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { 'testiaoaaoon' }
    password_confirmation { 'testiaoaaoon' }
  end
end
