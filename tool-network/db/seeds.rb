require 'open-uri'

Review.destroy_all
Category.destroy_all
Chat.destroy_all
Loan.destroy_all
Tool.destroy_all
User.destroy_all
Neighbourhood.destroy_all

neighbourhoods = [
  {name: "The Annex", postal_codes: ["M5R", "M5S"]},
  {name: "The Beaches", postal_codes: ["M4E", "M4L"]},
  {name: "Cabbagetown", postal_codes: ["M4X"]},
  {name: "Chinatown", postal_codes: ["M5T"]},
  {name: "The Danforth", postal_codes: ["M4J", "M4K"]},
  {name: "Distillery District", postal_codes: ["M5A"]},
  {name: "Downtown", postal_codes: ["M5G", "M5H", "M5J", "M5K", "M5L", "M6G", "M5V"]},
  {name: "Dundas West", postal_codes: ["M6J"]},
  {name: "High Park", postal_codes: ["M6P"]},
  {name: "The Junction", postal_codes: ["M6N", "M6P"]},
  {name: "Kensington Market", postal_codes: ["M5T"]},
  {name: "Leslieville", postal_codes: ["M4J", "M4L"]},
  {name: "Liberty Village", postal_codes: ["M6K"]},
  {name: "Little Italy", postal_codes: ["M5S"]},
  {name: "North York", postal_codes: ["M2H", "M2J", "M2K", "M2L", "M2M", "M2N", "M2P", "M2R", "M3A", "M3B", "M3C", "M3H", "M3J", "M3K", "M3L", "M3M", "M3N", "M4A", "M5M", "M6A", "M6B", "M6L", "M9L", "M9M"]},
  {name: "Parkdale", postal_codes: ["M6K 2N6", "M6K 2T8"]},
  {name: "Roncesvalles", postal_codes: ["M6R 1S1", "M6R 1G4"]},
  {name: "Scarborough", postal_codes: ["M1E", "M1J", "M1L"]},
  {name: "Trinity Bellwoods", postal_codes: ["M5T 2R7", "M6G 1A5"]},
  {name: "Yonge & Eglinton", postal_codes: ["M4P 0A2", "M4P 1G7"]},
  {name: "Yorkville", postal_codes: ["M4W", "M5R"]},
  {name: "Etobicoke", postal_codes: ["M9A"]}
]

user_names = ["Alyx", "Gurjant", "Daniel", "Maneesha", "Harisree", "Melissa", "Connor", "Sean", "Devon", "Natalie", "Niels", "Fred", "Jesse", "Elvis", "Najwa", "Matt", "Sanborn"]

postal_codes = ["M3A", "M4A", "M5A", "M6A", "M7A", "M9A", "M1B", "M3B", "M4B", "M5B", "M6B", "M9B", "M1C", "M3C", "M4C", "M5C", "M6C", "M9C", "M1E", "M4E", "M5E", "M6E", "M1G", "M4G", "M5G", "M6G", "M1H", "M2H", "M3H", "M4H", "M5H", "M6H", "M1J", "M2J", "M3J", "M4J", "M5J", "M6J", "M1K", "M2K", "M3K", "M4K", "M5K", "M6K", "M1L", "M2L", "M3L", "M4L", "M5L", "M6L", "M9L", "M1M", "M2M", "M3M", "M4M", "M5M", "M6M", "M9M", "M1N", "M2N", "M3N", "M4N", "M5N", "M6N", "M9N", "M1P", "M2P", "M3P", "M4P", "M5P", "M6P", "M9P", "M1P", "M2P", "M4P", "M5P", "M6P", "M9P", "M1R", "M2R", "M4R", "M5R", "M6R", "M7R", "M9R", "M1S", "M4S", "M5S", "M6S", "M1T", "M4T", "M5T", "M1V", "M4V", "M5V", "M8V", "M9V", "M1W", "M4W", "M5W", "M8W", "M9W", "M1X", "M4X", "M5X", "M8X", "M4Y", "M7Y", "M8Y", "M8Z"]


# Create neighbourhoods
neighbourhoods.each_with_index do |nbhd, i|
  neighbourhood = Neighbourhood.new(name: nbhd[:name])
  neighbourhood.nbhd_image = File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/neighbourhood_images/#{i}.jpg"))
  neighbourhood.save!
end

# Create users
dmitry = User.create!(name: "Dmitry", email: "dmitry.sbn@gmail.com", password: "testtest", password_confirmation: "testtest", postal_code: "M6J 1X8", neighbourhood: Neighbourhood.find_by(name: "Dundas West"))
alex = User.create!(name: "Alex", email: "alex@gmail.com", password: "testtest", password_confirmation: "testtest", postal_code: "M6G 1B9", neighbourhood: Neighbourhood.find_by(name: "Dundas West"))
debbie = User.create!(name: "Debbie", email: "drosenfeld87@gmail.com", password: "testtest", password_confirmation: "testtest", postal_code: "M6P 1Y9", neighbourhood: Neighbourhood.find_by(name: "The Junction"))
bill = User.create!(name: "Bill", email: "li_bill@ymail.com", password: "testtest", password_confirmation: "testtest", postal_code: "M5V 2T6", neighbourhood: Neighbourhood.find_by(name: "Downtown"))

(0..16).to_a.each_with_index do |number, i|
  name = user_names[i]
  neighbourhood = Neighbourhood.all.sample
  postal_code = neighbourhoods.find {|nbhd| nbhd[:name] = neighbourhood.name }[:postal_codes].sample

  user = User.create!(
    name: name,
    email: "#{name.downcase}@gmail.com",
    password: "testtest",
    password_confirmation: "testtest",
    neighbourhood: neighbourhood,
    postal_code: postal_code,
    avatar: File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/user_avatars/#{name}.jpg"))
  )
end

# Create tools
badminton_racket = Tool.create!(
  name: "Badminton racket",
  description: "Like new!",
  condition: 10,
  owner: User.all.sample,
  on_loan: false,
  loan_length: 2,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/badminton1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/badminton2.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/badminton3.jpg"))
  ])
bbq = Tool.create!(
  name: "BBQ Grill",
  description: "For rare steaks ONLY!",
  condition: 7,
  owner: User.all.sample,
  on_loan: false,
  loan_length: 4,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/bbq1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/bbq2.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/bbq3.jpg"))
  ])
bicycle = Tool.create!(
  name: "Bike",
  description: "Some kind of mountain bike. Perfect for this city's paved roads.",
  condition: 7,
  owner: User.all.sample,
  on_loan: false,
  loan_length: 4,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/bicycle1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/bicycle2.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/bicycle3.jpg"))
  ])
bouncy_castle = Tool.create!(
  name: "Bouncy Castle",
  description: "Fun for the whole family.",
  condition: 5,
  owner: User.all.sample,
  on_loan: false,
  loan_length: 5,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/bouncycastle1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/bouncycastle2.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/bouncycastle3.jpg"))
  ])
carjack = Tool.create!(
  name: "Carjack",
  description: "For when your tire gets slashed.",
  condition: 10,
  owner: User.all.sample,
  on_loan: false,
  loan_length: 1,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/carjack1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/carjack2.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/carjack3.jpg"))
    ])
fitbit = Tool.create!(
  name: "Fitbit",
  description: "Get fit.",
  condition: 8,
  owner: User.all.sample,
  on_loan: false,
  loan_length: 1,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/fitbit1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/fitbit2.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/fitbit3.jpg"))
    ])
folding_chair = Tool.create!(
  name: "Folding chair",
  description: "For when your kids play soccer. Beer not included.",
  condition: 9,
  owner: User.all.sample,
  on_loan: false,
  loan_length: 1,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/foldingchair1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/foldingchair2.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/foldingchair3.jpg"))
    ])
food_processor = Tool.create!(
  name: "Foor processor",
  description: "I'm really not quite sure what it does.",
  condition: 5,
  owner: User.all.sample,
  on_loan: false,
  loan_length: 1,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/foodprocessor1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/foodprocessor2.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/foodprocessor3.jpg"))
    ])
garden_shears = Tool.create!(
  name: "Garden shears",
  description: "Keep away from children and pets.",
  condition: 4,
  owner: User.all.sample,
  on_loan: false,
  loan_length: 1,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/gardenshears1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/gardenshears2.jpg"))
    ])
go_pro = Tool.create!(
  name: "GoPro",
  description: "For all your extreme sporting needs.",
  condition: 7,
  owner: User.all.sample,
  on_loan: false,
  loan_length: 1,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/gopro1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/gopro2.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/gopro3.jpg"))
    ])
hammer = Tool.create!(
  name: "Hammer",
  description: "Original inspiration for this project. Supreme quality.",
  condition: 10,
  owner: User.find_by(name: "Dmitry"),
  on_loan: false,
  loan_length: 1,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/supremehammer.jpg"))
    ])
karaoke = Tool.create!(
  name: "Karaoke",
  description: "It's not the mic, it's the singer.",
  condition: 8,
  owner: User.all.sample,
  on_loan: false,
  loan_length: 3,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/karaoke1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/karaoke2.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/karaoke3.jpg"))
    ])
ladder = Tool.create!(
  name: "Ladder",
  description: "Safety always first. Polish contractors' favourite.",
  condition: 7,
  owner: User.all.sample,
  on_loan: false,
  loan_length: 3,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/ladder1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/ladder2.jpg"))
    ])
lawnmower = Tool.create!(
  name: "Lawnmower",
  description: "Perfect for those early Saturday mornings.",
  condition: 3,
  owner: User.all.sample,
  on_loan: false,
  loan_length: 3,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/lawnmower1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/lawnmower2.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/lawnmower3.jpg"))
    ])
margarita_mixer = Tool.create!(
  name: "Margarita mixer",
  description: "Despite what anyone tells you, it's never too early.",
  condition: 8,
  owner: User.all.sample,
  on_loan: false,
  loan_length: 3,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/margaritamixer1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/margaritamixer2.jpg"))
    ])
moving_trolley = Tool.create!(
  name: "Moving trolley",
  description: "For when the groceries are too heavy.",
  condition: 8,
  owner: User.all.sample,
  on_loan: false,
  loan_length: 3,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/movingtrolley1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/movingtrolley2.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/movingtrolley3.jpg"))
    ])
outdoor_speaker = Tool.create!(
  name: "Outdoor speaker",
  description: "Why wouldn't the entire neighbourhood share your taste in music?",
  condition: 8,
  owner: User.all.sample,
  on_loan: false,
  loan_length: 3,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/outdoorspeaker1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/outdoorspeaker2.jpg"))
    ])
pet_carrier = Tool.create!(
  name: "Pet carrier",
  description: "Your cat will love this mobile home. Inside is heavily scratched.",
  condition: 5,
  owner: User.all.sample,
  on_loan: false,
  loan_length: 3,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/petcarrier1.jpg"))
    ])
power_drill = Tool.create!(
  name: "Power drill",
  description: "Wrrhhhhhhh.",
  condition: 5,
  owner: User.all.sample,
  on_loan: false,
  loan_length: 3,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/powerdrill1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/powerdrill2.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/powerdrill3.jpg"))
    ])
rollerblades = Tool.create!(
  name: "Rollerblades",
  description: "These are inline.",
  condition: 5,
  owner: User.all.sample,
  on_loan: false,
  loan_length: 3,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/rollerblades1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/rollerblades2.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/rollerblades3.jpg"))
    ])
stepper = Tool.create!(
  name: "...Stepper?",
  description: "For stepping on repeatedly.",
  condition: 5,
  owner: User.all.sample,
  on_loan: false,
  loan_length: 3,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/stepper1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/stepper2.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/rollerblades3.jpg"))
    ])
suitcase = Tool.create!(
  name: "Suitcase",
  description: "Zebra-patterned. Not for legal meetings.",
  condition: 5,
  owner: User.all.sample,
  on_loan: false,
  loan_length: 3,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/suitcase1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/suitcase2.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/suitcase3.jpg"))
    ])
tent = Tool.create!(
  name: "Tent",
  description: "Like new. Still has that fresh rubber smell. May be borrowed for up to 10 days!",
  condition: 9,
  owner: User.all.sample,
  on_loan: false,
  loan_length: 10,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/tent1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/tent2.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/tent3.jpg"))
    ])
tire_inflator = Tool.create!(
  name: "Tire inflator",
  description: "Users who have borrowed this also borrowed: Carjack.",
  condition: 9,
  owner: User.all.sample,
  on_loan: false,
  loan_length: 10,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/tireinflator1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/tireinflator2.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/tireinflator3.jpg"))
    ])
video_camera = Tool.create!(
  name: "Video camera",
  description: "For the cinematographer in all of us.",
  condition: 9,
  owner: User.all.sample,
  on_loan: false,
  loan_length: 10,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/videocamera1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/videocamera2.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/videocamera3.jpg"))
    ])
walkie_talkie = Tool.create!(
  name: "Walkie-talkie",
  description: "Effective range of up to 500 meters.",
  condition: 7,
  owner: User.all.sample,
  on_loan: false,
  loan_length: 10,
  owner_pictures: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/walkietalkie1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/walkietalkie2.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_owner_images/walkietalkie3.jpg"))
    ])

# Create loans
tools_borrowed = [
  bbq, carjack, fitbit, folding_chair, food_processor, garden_shears, go_pro, karaoke, ladder, lawnmower, margarita_mixer, moving_trolley, outdoor_speaker, pet_carrier, power_drill, rollerblades, stepper, tent, tire_inflator, walkie_talkie
]

tools_borrowed.each do |tool|
  loan = Loan.create!(
    start_date: Date.today,
    due_date: Date.today + rand(5) + 5,
    borrower: User.all.sample,
    tool: tool,
    active: false
  )
end

# Create reviews
bbq_review = Review.create!(
  comment: "The charred steaks were delicious... said no one ever.",
  rating: 5,
  user: bbq.borrowers.last,
  tool: bbq,
  images: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/bbq-review1.jpg"))
  ])
carjack_review = Review.create!(
  comment: "Did not help with carjacking.",
  rating: 1,
  user: carjack.borrowers.last,
  tool: carjack,
  images: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/carjack-review1.jpg"))
  ])
fitbit_review = Review.create!(
  comment: "My heart rate went through the roof!",
  rating: 4,
  user: fitbit.borrowers.last,
  tool: fitbit,
  images: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/fitbit-review1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/fitbit-review2.jpg"))
  ])
folding_chair_review = Review.create!(
  comment: "Was perfect with the BBQ Grill that I borrowed.",
  rating: 5,
  user: folding_chair.borrowers.last,
  tool: folding_chair,
  images: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/foldingchair-review1.jpg"))
  ])
food_processor_review = Review.create!(
  comment: "I've processed the food.",
  rating: 5,
  user: food_processor.borrowers.last,
  tool: food_processor,
  images: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/foodprocessor-review1.jpg"))
  ])
garden_shears_review = Review.create!(
  comment: "Perfect for those edges.",
  rating: 5,
  user: garden_shears.borrowers.first,
  tool: garden_shears,
  images: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/gardenshears-review1.jpg"))
  ])
go_pro_review1 = Review.create!(
  comment: "Went skiing!",
  rating: 5,
  user: go_pro.borrowers.first,
  tool: go_pro,
  images: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/gopro-review1.jpg"))
  ])
go_pro_review2 = Review.create!(
  comment: "Went skiing again!",
  rating: 5,
  user: go_pro.borrowers.first,
  tool: go_pro,
  images: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/gopro-review2.jpg"))
  ])
go_pro_review3 = Review.create!(
  comment: "Then I went snowboarding!",
  rating: 5,
  user: go_pro.borrowers.first,
  tool: go_pro,
  images: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/gopro-review3.jpg"))
  ])
karaoke_review = Review.create!(
  comment: "The microphone was off.",
  rating: 5,
  user: karaoke.borrowers.last,
  tool: karaoke,
  images: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/karaoke-review1.jpg"))
  ])
ladder_review = Review.create!(
  comment: "Almost fell down.",
  rating: 1,
  user: ladder.borrowers.last,
  tool: ladder,
  images: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/ladder-review1.jpg"))
  ])
lawnmower_review = Review.create!(
  comment: "Nothing feels better than waking up my neighbours with a combination of noise and gasoline smell at 7am on Saturday! I love being an asshole.",
  rating: 5,
  user: lawnmower.borrowers.last,
  tool: lawnmower,
  images: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/lawnmower-review1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/lawnmower-review2.jpg"))
  ])
margarita_mixer_review = Review.create!(
  comment: "The only thing better than a Margarita is two Margaritas.",
  rating: 5,
  user: margarita_mixer.borrowers.last,
  tool: margarita_mixer,
  images: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/margaritamixer-review1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/margaritamixer-review2.jpg"))
  ])
moving_trolley_review = Review.create!(
  comment: "The trolley was truly moving.",
  rating: 4,
  user: moving_trolley.borrowers.last,
  tool: moving_trolley,
  images: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/movingtrolley-review1.jpg"))
  ])
outdoor_speaker_review = Review.create!(
  comment: "Good for drowning out the sound of a lawnmower.",
  rating: 4,
  user: outdoor_speaker.borrowers.last,
  tool: outdoor_speaker,
  images: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/outdoorspeaker-review1.jpg"))
  ])
pet_carrier_review = Review.create!(
  comment: "My dog hated this.",
  rating: 1,
  user: pet_carrier.borrowers.last,
  tool: pet_carrier,
  images: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/petcarrier-review1.jpg"))
  ])
power_drill_review = Review.create!(
  comment: "I really should have checked for wires behind the drywall first.",
  rating: 1,
  user: power_drill.borrowers.last,
  tool: power_drill,
  images: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/powerdrill-review1.jpg")),
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/powerdrill-review2.jpg"))
  ])
rollerblades_review = Review.create!(
  comment: "It was all fun and games until I fell square on my face.",
  rating: 2,
  user: rollerblades.borrowers.last,
  tool: rollerblades,
  images: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/rollerblades-review1.jpg"))
  ])
stepper_review = Review.create!(
  comment: "I did not notice the water levels rising until it was too late.",
  rating: 3,
  user: stepper.borrowers.last,
  tool: stepper,
  images: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/stepper-review1.jpg"))
  ])
tent_review = Review.create!(
  comment: "The tent no longer has that fresh rubber smell.",
  rating: 3,
  user: tent.borrowers.last,
  tool: tent,
  images: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/tent-review1.jpg"))
  ])
tire_inflator_review = Review.create!(
  comment: "The pressure gauge was precise up to 0.1 psi.",
  rating: 5,
  user: tire_inflator.borrowers.last,
  tool: tire_inflator,
  images: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/tireinflator-review1.jpg"))
  ])
walkie_talkie_review = Review.create!(
  comment: "I realized too late that only one of these was not enough.",
  rating: 5,
  user: walkie_talkie.borrowers.last,
  tool: walkie_talkie,
  images: [
    File.new(File.join(Rails.root, "/app/assets/images/seed_data_images/temp_review_images/walkietalkie-review1.jpg"))
  ])

# Create categories
Category.create(:category_name => 'Tools')
Category.create(:category_name => 'Auto')
Category.create(:category_name => 'Outdoor home')
Category.create(:category_name => 'Indoor home')
Category.create(:category_name => 'Audio')
Category.create(:category_name => 'Video')
Category.create(:category_name => 'Sports')
Category.create(:category_name => 'Health')
