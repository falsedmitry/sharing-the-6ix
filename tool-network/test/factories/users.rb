FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "person#{n}" }
    sequence(:email) { |n| "person#{n}@example.com" }
    password "testtest"
    password_confirmation "testtest"
    location "Toronto"
    photo "no photo"
  end
end
