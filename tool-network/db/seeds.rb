
Image.destroy_all
Review.destroy_all
Tool.destroy_all

User.destroy_all

dmitry = User.create(name: "Dmitry", email: "dmitry@gmail.com", password: "test", password_confirmation: "test", location: "Dundas", photo: "no photo")

alex = User.create(name: "Alex", email: "alex@gmail.com", password: "test", password_confirmation: "test", location: "King", photo: "no photo")

debbie = User.create(name: "Debbie", email: "debbie@gmail.com", password: "test", password_confirmation: "test", location: "Junction", photo: "no photo")

bill = User.create(name: "Bill", email: "bill@gmail.com", password: "test", password_confirmation: "test", location: "Markham", photo: "no photo")

# Image.create(:category_name => 'technology')
# Image.create(:category_name =>'art')
# Image.create(:category_name => 'sports')
# Image.create(:category_name => 'food')

10.times do
  tool = Tool.create!(
              name: Faker::App.name,
              description: Faker::Lorem.paragraph,
              condition: rand(10),
              owner: User.first,
              on_loan: false,
            )
            # tool.categories = [Image.first]

  5.times do
    tool.reviews.create!(
      comment: Faker::Lorem.paragraph,
      rating: rand(5),
      user: User.first,
      tool: Tool.first
    )
  end
end
