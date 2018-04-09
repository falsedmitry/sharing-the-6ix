Image.destroy_all
Review.destroy_all
Loan.destroy_all
Tool.destroy_all
User.destroy_all
Category.destroy_all
Neighbourhood.destroy_all

annex = Neighbourhood.create(name: "The Annex")
parkdale = Neighbourhood.create(name: "Parkdale")
junction = Neighbourhood.create(name: "The Junction")
little_italy = Neighbourhood.create(name: "Little Italy")
beaches = Neighbourhood.create(name: "The Beaches")
dundas_west = Neighbourhood.create(name: "Dundas West")
yorkville = Neighbourhood.create(name: "Yorkville")
downtown = Neighbourhood.create(name: "Downtown")
kensington_market = Neighbourhood.create(name: "Kensington Market")
chinatown = Neighbourhood.create(name: "Chinatown")
roncesvalles = Neighbourhood.create(name: "Roncesvalles")
yonge_eglinton = Neighbourhood.create(name: "Yonge & Eglinton")
east_york = Neighbourhood.create(name: "East York")
danforth = Neighbourhood.create(name: "The Danforth")
cabbagetown = Neighbourhood.create(name: "Cabbagetown")
liberty_village = Neighbourhood.create(name: "Liberty Village")
leslieville = Neighbourhood.create(name: "Leslieville")
north_york = Neighbourhood.create(name: "North York")
scarborough = Neighbourhood.create(name: "Scarborough")
etobicoke = Neighbourhood.create(name: "Etobicoke")

dmitry = User.create(name: "Dmitry", email: "dmitry@gmail.com", password: "testtest", password_confirmation: "testtest", location: "M6J 1X8", neighbourhood: dundas_west)

alex = User.create(name: "Alex", email: "alex@gmail.com", password: "testtest", password_confirmation: "testtest", location: "M6J 1X9", neighbourhood: dundas_west)

debbie = User.create(name: "Debbie", email: "debbie@gmail.com", password: "testtest", password_confirmation: "testtest", location: "Junction", neighbourhood: junction)

bill = User.create(name: "Bill", email: "bill@gmail.com", password: "testtest", password_confirmation: "testtest", location: "Markham", neighbourhood: beaches)

# Image.create(:category_name => 'technology')
# Image.create(:category_name =>'art')
# Image.create(:category_name => 'sports')
# Image.create(:category_name => 'food')

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
