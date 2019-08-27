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
    "Our dedicated community holds regular events for our feral cats.",
    "We strive to achieve quality care for stray cats.",
    "We love cats and work towards the best care possible for our strays.",
    "Our cats are fat, happy, and wise.",
    "Cats, cats, cats!",
    "Our cats are very well-fed.",
    "We try and rehome as many strays as possible and ensure the neutering process is as smooth as possible.",
    "Our community believes in providing the five-star experience that our cats deserve.",
    "These cats are very friendly and not afraid of humans, please treat them nicely!"]

    sentences.sample(rand(3..9)).join(" ")
end

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
admins = []
13.times do
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

puts 'Adding untracked cats...'
scrape_addresses("places in tokyo").each do |result|
  Cat.create!(cat_stats(nil, result['formatted_address']))
end

ueno_addresses = scrape_addresses("places in ueno").first(8)
ueno_addresses.each do |result|
  Cat.create!(cat_stats(nil, result['formatted_address']))
end

puts 'Creating colonies...'
colony_addresses = ['Shinagawa', 'Roppongi', 'Meguro', 'Shibuya', 'Shinjuku', 'Ikebukuro', 'Asakusa', 'Odaiba', 'Kagurazaka', 'Akihabara', 'Ginza', 'Kitasenju', 'Hanzomon']
colony_addresses.each do |address|
  Colony.create!(
    name: "#{address} Cat Colony",
    address: "#{address}",
    description: generate_description,
    radius: 1)
end

puts 'Adding cats to colonies...'
Colony.all.each do |colony|
  addresses = scrape_addresses("places in #{colony.address}").first(rand(5..10))
  addresses.each do |address|
    Cat.create!(cat_stats(colony, address['formatted_address'], rand(0..5)))
  end
  colony.update(radius: colony.cats.length.to_f / 6)
  colony.save!
end

puts 'Assigning admins to each colony...'
admins.each_with_index do |admin, index|
  admin.associations = [Association.create!(admin: true, user: admin, colony: Colony.all[index])]
end

puts 'Assigning volunteers to each colony...'
Colony.all.each do |colony|
  rand(8..10).times do
    user = User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      age: rand(15..60),
      gender: ['Male', 'Female'].sample,
      email: Faker::Internet.email,
      password: '123456',
      phone_number: Faker::PhoneNumber.cell_phone)
    Association.create!(user: user, colony: colony)
  end
end

puts 'Creating events and adding participants...'
Colony.all.each do |colony|
  event_1 = Event.create!(
    title: 'TNR Meetup',
    description: "Gotta catch 'em all!",
    address: colony.address,
    start: DateTime.now,
    end: (DateTime.now.to_time + rand(3..8).hours).to_datetime,
    colony: colony,
    phase: 0)
  Participation.create!(user: colony.admins.first, event: event_1)
  rand(4..6).times do
    Participation.create!(user: colony.non_admins.sample, event: event_1)
  end

  event_2 = Event.create!(
    title: 'Monthly checkup',
    description: "Kitty roundup for the monthly checkup.",
    address: colony.address,
    start: DateTime.tomorrow,
    end: (DateTime.tomorrow.to_time + rand(3..8).hours).to_datetime,
    colony: colony,
    phase: 3)
  Participation.create!(user: colony.admins.first, event: event_2)
  rand(4..6).times do
    Participation.create!(user: colony.non_admins.sample, event: event_2)
  end
end

puts 'All seeded!'
