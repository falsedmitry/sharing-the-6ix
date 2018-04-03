FactoryBot.define do
  factory :tool do
    sequence(:name) { |n| "tool#{n}" }
    on_loan false
    condition 10
    description "This is a good tool lol"
    loan_length 10
  end
end
