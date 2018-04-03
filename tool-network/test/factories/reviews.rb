FactoryBot.define do
  factory :review do
    date Date.today
    rating 5
    comment "This tool did the job."
  end
end
