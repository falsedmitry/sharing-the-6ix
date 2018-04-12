FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "person#{n}" }
    sequence(:email) { |n| "person#{n}@example.com" }
    password "testtest"
    password_confirmation "testtest"
    postal_code "M6J 1X8"
    neighbourhood { Neighbourhood.create(name: "The Annex") }
  end
end
