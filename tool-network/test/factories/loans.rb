FactoryBot.define do
  factory :loan do
    start_date Date.today
    due_date Date.tomorrow
    active true
  end
end
