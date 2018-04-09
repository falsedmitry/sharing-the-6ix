Review.destroy_all
Loan.destroy_all
Tool.destroy_all
User.destroy_all
Category.destroy_all
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

neighbourhood_names.each do |nbhd_name|
  Neighbourhood.create(name: nbhd_name)
end

dmitry = User.create(name: "Dmitry", email: "dmitry@gmail.com", password: "testtest", password_confirmation: "testtest", location: "M6J 1X8", neighbourhood: Neighbourhood.find_by(name: "Dundas West"))

alex = User.create(name: "Alex", email: "alex@gmail.com", password: "testtest", password_confirmation: "testtest", location: "M6J 1X9", neighbourhood: Neighbourhood.find_by(name: "Dundas West"))

debbie = User.create(name: "Debbie", email: "debbie@gmail.com", password: "testtest", password_confirmation: "testtest", location: "Junction", neighbourhood: Neighbourhood.find_by(name: "The Junction"))

bill = User.create(name: "Bill", email: "bill@gmail.com", password: "testtest", password_confirmation: "testtest", location: "Markham", neighbourhood: Neighbourhood.find_by(name: "The Beaches"))

10.times do
  tool = Tool.create!(
              name: Faker::App.name,
              description: Faker::Lorem.paragraph,
              condition: rand(10)+1,
              owner: User.first,
              on_loan: false,
              loan_length: rand(30)+1,
              owner_pictures: nil
            )
            # tool.categories = [Image.first]

  5.times do
    tool.reviews.create!(
      comment: Faker::Lorem.paragraph,
      rating: rand(5)+1,
      user: User.first,
      tool: Tool.first
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
