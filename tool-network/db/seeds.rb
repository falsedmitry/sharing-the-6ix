Review.destroy_all
Category.destroy_all
Chat.destroy_all
Tool.destroy_all
User.destroy_all
Loan.destroy_all
Neighbourhood.destroy_all

neighbourhood_names = [
  "The Annex",
  "Parkdale",
  "The Junction",
  "Little Italy",
  "The Beaches",
  "Dundas West",
  "Yorkville",
  "Downtown",
  "Kensington Market",
  "Chinatown",
  "Roncesvalles",
  "Yonge & Eglinton",
  "East York",
  "The Danforth",
  "Cabbagetown",
  "Liberty Village",
  "Leslieville",
  "North York",
  "Scarborough",
  "Etobicoke"
]

postal_codes = [
  "M3A",
  "M4A",
  "M5A",
  "M6A",
  "M7A",
  "M9A",
  "M1B",
  "M3B",
  "M4B",
  "M5B",
  "M6B",
  "M9B",
  "M1C",
  "M3C",
  "M4C",
  "M5C",
  "M6C",
  "M9C",
  "M1E",
  "M4E",
  "M5E",
  "M6E",
  "M1G",
  "M4G",
  "M5G",
  "M6G",
  "M1H",
  "M2H",
  "M3H",
  "M4H",
  "M5H",
  "M6H",
  "M1J",
  "M2J",
  "M3J",
  "M4J",
  "M5J",
  "M6J",
  "M1K",
  "M2K",
  "M3K",
  "M4K",
  "M5K",
  "M6K",
  "M1L",
  "M2L",
  "M3L",
  "M4L",
  "M5L",
  "M6L",
  "M9L",
  "M1M",
  "M2M",
  "M3M",
  "M4M",
  "M5M",
  "M6M",
  "M9M",
  "M1N",
  "M2N",
  "M3N",
  "M4N",
  "M5N",
  "M6N",
  "M9N",
  "M1P",
  "M2P",
  "M3P",
  "M4P",
  "M5P",
  "M6P",
  "M9P",
  "M1P",
  "M2P",
  "M4P",
  "M5P",
  "M6P",
  "M9P",
  "M1R",
  "M2R",
  "M4R",
  "M5R",
  "M6R",
  "M7R",
  "M9R",
  "M1S",
  "M4S",
  "M5S",
  "M6S",
  "M1T",
  "M4T",
  "M5T",
  "M1V",
  "M4V",
  "M5V",
  "M8V",
  "M9V",
  "M1W",
  "M4W",
  "M5W",
  "M8W",
  "M9W",
  "M1X",
  "M4X",
  "M5X",
  "M8X",
  "M4Y",
  "M7Y",
  "M8Y",
  "M8Z"
]

neighbourhood_names.each do |nbhd_name|
  Neighbourhood.create(name: nbhd_name)
end

dmitry = User.create(name: "Dmitry", email: "dmitry@gmail.com", password: "testtest", password_confirmation: "testtest", postal_code: "M6J 1X8", neighbourhood: Neighbourhood.find_by(name: "Dundas West"))
alex = User.create(name: "Alex", email: "alex@gmail.com", password: "testtest", password_confirmation: "testtest", postal_code: "M6J 1X9", neighbourhood: Neighbourhood.find_by(name: "Dundas West"))
debbie = User.create(name: "Debbie", email: "debbie@gmail.com", password: "testtest", password_confirmation: "testtest", postal_code: "Junction", neighbourhood: Neighbourhood.find_by(name: "The Junction"))
bill = User.create(name: "Bill", email: "bill@gmail.com", password: "testtest", password_confirmation: "testtest", postal_code: "Markham", neighbourhood: Neighbourhood.find_by(name: "The Beaches"))

(1..20).to_a.each do |number|
  User.create(
    name: "User #{number}",
    email: "user#{number}@gmail.com",
    password: "testtest",
    password_confirmation: "testtest",
    postal_code: postal_codes.sample,
    neighbourhood: Neighbourhood.all.sample
  )
end

10.times do
  tool = Tool.create!(
              name: Faker::App.name,
              description: Faker::Lorem.paragraph,
              condition: rand(10)+1,
              owner: User.all.sample,
              on_loan: false,
              loan_length: rand(30)+1,
              owner_pictures: nil
            )

  5.times do
    tool.reviews.create!(
      comment: Faker::Lorem.paragraph,
      rating: rand(5)+1,
      user: User.all.sample,
      tool: Tool.all.sample
    )
  end
end

Category.create(:category_name => 'Tools')
Category.create(:category_name => 'Auto')
Category.create(:category_name => 'Outdoor home')
Category.create(:category_name => 'Indoor home')
Category.create(:category_name => 'Audio')
Category.create(:category_name => 'Video')
Category.create(:category_name => 'Sports')
Category.create(:category_name => 'Health')
