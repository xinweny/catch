require 'json'
require 'open-uri'

def scrape_addresses(query)
  url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=#{query}&key=#{ENV['GOOGLE_API_SERVER_KEY']}"
  addresses = JSON.parse(open(url).read)['results']
end

def cat_stats(colony, address, status = 0)
  return {
  name: Faker::Creature::Cat.name,
  description: Faker::Creature::Cat.breed,
  address: address,
  sex: rand(0..1),
  age: rand(0..10),
  status: status,
  remote_photo_url: 'https://cataas.com/cat',
  colony: colony
  }
end

def generate_description
  sentences = ["We are an active community of cat lovers.",
    "We believe in the inherent goodness of cats.",
    "We are happiest when helping cats.",
    "Our community holds regular events for our feral cats.",
    "We strive to achieve quality care for stray cats.",
    "We love cats and work towards the best care possible for our strays.",
    "Our cats are fat, happy, and wise.",
    "Cats, cats, cats!",
    "Our cats are very well-fed.",
    "We try and rehome as many strays as possible and ensure the neutering process is as smooth as possible.",
    "Our community believes in providing a five-star experience for our cats."]
end

puts 'Scraping Google Map addresses...'
# shinagawa_addresses = ['Oimachi Station', 'Shinagawa Post Office', 'Soyokaze Park', 'Osaki Station', 'Takioji Nursery', 'Shiki Theatre Natsu', 'Shinagawa Central Park']
# meguro_addresses = ['Meguro City Hall', 'Yutenji Temple', 'Nakameguro Elementary School', 'Shokakuji Temple', 'Nakameguro Station Post Office', 'Naka-Meguro Station']
# shibuya_addresses = ['Shibuya 101', 'Ichiran Shibuya', 'Tokyu Hands Shibuya', 'Hachiko Memorial Statue', 'Aoyama Gakuin University', 'Shibuya Post Office', 'Cat Street Gallery', 'NHK Hall', 'Shibuya Mark City', 'Josenji Temple']
# random_addresses = ['Ueno Toshogu Shrine', 'Ueno Zoo', 'Ueno Station', 'Okachimachi Station', 'Tokyo National Museum', 'Yamabushi Park', 'Uenonomori Christian Church', 'Ueno Fire Station', 'Ueno Police Station', 'Shinobazu Pond']

puts 'Wiping the development db...'
User.destroy_all if Rails.env.development?
Cat.destroy_all if Rails.env.development?
Colony.destroy_all if Rails.env.development?
Event.destroy_all if Rails.env.development?

puts 'Creating demo user...'
demo_user = [User.create!(
    first_name: 'Carmen',
    last_name: 'Chung',
    age: 21,
    gender: 'Female',
    email: 'test@gmail.com',
    password: '123456',
    phone_number: '012-345-6789')]

puts 'Creating admins...'
2.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    age: rand(15..60),
    gender: ['Male', 'Female'].sample,
    email: Faker::Internet.email,
    password: '123456',
    phone_number: Faker::PhoneNumber.cell_phone)
  admins << user
  user.save!
end

puts 'Creating volunteers...'
other_users = []
15.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    age: rand(15..60),
    gender: ['Male', 'Female'].sample,
    email: Faker::Internet.email,
    password: '123456',
    phone_number: Faker::PhoneNumber.cell_phone)
  other_users << user
  user.save!
end

puts 'Creating colonies...'
colony_addresses = ['Shinagawa', 'Gotanda', 'Meguro', 'Shibuya', 'Shinjuku', 'Ikebukuro', 'Asakusa', 'Omotesando', 'Odaiba', 'Hakusan', 'Akihabara', 'Ginza', 'Tsukishima', 'Kitasenju', 'Hanzomon']
colony_addresses.each do |address|
  Colony.create!(
    name: "#{address} Cat Colony",
    address: "#{address}",
    description: "")
end
# shinagawa = Colony.create!(
#   name: 'Shinagawa Cat Colony',
#   address: 'Shinagawa',
#   description: "A small colony of 5 cats. They're very used to people but because of that they're all pretty fat from all the food they receive from old ladies.",
#   radius: 1
#   )

# meguro = Colony.create!(
#   name: 'Meguro Cat Colony',
#   address: 'Meguro',
#   description: "A medium sized colony of 8 cats. Newly established. These cats are very wary of people and can become aggressive when confronted.",
#   radius: 1.5
#   )

# shibuya = Colony.create!(
#   name: 'Shibuya Cat Colony',
#   address: 'Shibuya',
#   description: "A large colony of 12 cats, growing due to abundance of food scraps from tourists. They mostly hang out around the back alleys of izakayas in the area.",
#   radius: 3
#   )

colonies = [shinagawa, meguro, shibuya]

puts 'Adding untracked cats...'
random_addresses.each do |address|
  Cat.create!(cat_stats(nil, address))
end

puts 'Adding cats to colonies...'
5.times do
  Cat.create!(cat_stats(shinagawa, shinagawa_addresses.sample, rand(0..5)))
end

8.times do
  Cat.create!(cat_stats(meguro, meguro_addresses.sample, rand(0..5)))
end

12.times do
  Cat.create!(cat_stats(shibuya, shibuya_addresses.sample, rand(0..5)))
end

puts 'Assigning admins to each colony...'
admins.each_with_index do |admin, index|
  admin.associations = [Association.create!(admin: true, user: admin, colony: colonies[index])]
end

puts 'Assigning volunteers to each colony...'
other_users.each do |user|
  Colony.all.sample.users << user
end

puts 'Creating events...'
colonies.each do |colony|
  event_1 = Event.create!(
    title: 'TNR Meetup',
    description: "Gotta catch 'em all!",
    address: colony.address,
    start: DateTime.now,
    end: (DateTime.now.to_time + rand(3..8).hours).to_datetime,
    colony: colony,
    phase: 0)
  Participation.create!(user: colony.admins.first, event: event_1)

  event_2 = Event.create!(
    title: 'Monthly checkup',
    description: "Kitty roundup for the monthly checkup.",
    address: colony.address,
    start: DateTime.now,
    end: (DateTime.now.to_time + rand(3..8).hours).to_datetime,
    colony: colony,
    phase: 3)
  Participation.create!(user: colony.admins.first, event: event_2)
end

puts 'All seeded!'
