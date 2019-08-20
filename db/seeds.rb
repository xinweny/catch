# 3 colonies - meguro, shinagawa, shibuya
# cats - 5, 12, 15
# user - 4 admins, 10 users
# event - 2 each
require 'faker'

def cat_stats(colony)
  return {
  name: Faker::Creature::Cat.name,
  description: Faker::Creature::Cat.breed,
  sex: ['Male', 'Female'].sample,
  age: rand(0..10),
  status: rand(0..5),
  remote_photo_url: 'https://cataas.com/cat',
  colony: colony
  }
end

puts 'Wiping the development db...'
User.destroy_all if Rails.env.development?
Cat.destroy_all if Rails.env.development?
Colony.destroy_all if Rails.env.development?
Event.destroy_all if Rails.env.development?

puts 'Creating admins...'
admins = [User.create!(
    first_name: 'Rachel',
    last_name: 'Wong',
    age: 21,
    gender: 'Female',
    email: 'test@gmail.com',
    password: '123456',
    phone_number: '012-345-6789')]

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
10.times do
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
shinagawa = Colony.create!(
  name: 'Shinagawa Cat Colony',
  address: 'Shinagawa',
  description: "A small colony of 5 cats. They're very used to people but because of that they're all pretty fat from all the food they receive from old ladies.",
  radius: 3
  )

meguro = Colony.create!(
  name: 'Meguro Cat Colony',
  address: 'Meguro',
  description: "A medium sized colony of 12 cats. Newly established. These cats are very wary of people and can become aggressive when confronted.",
  radius: 6
  )

shibuya = Colony.create!(
  name: 'Shibuya Cat Colony',
  address: 'Shibuya',
  description: "A large colony of 15 cats, growing due to abundance of food scraps from tourists. They mostly hang out around the back alleys of izakayas in the area.",
  radius: 9
  )

colonies = [shinagawa, meguro, shibuya]

puts 'Adding cats...'
5.times do
  Cat.create!(cat_stats(shinagawa))
end

12.times do
  Cat.create!(cat_stats(meguro))
end

15.times do
  Cat.create!(cat_stats(shibuya))
end


puts 'Assigning admins to each colony...'
admins.each_with_index do |admin, index|
  admin.colonies = [Colony.all[index]]
end

puts 'Assigning volunteers...'
other_users.each do |user|
  Colony.all.sample.users << user
end

puts 'Creating events...'
colonies.each do |colony|
  Event.create!(
    title: 'TNR Meetup',
    description: "Gotta catch 'em all!",
    address: colony.address,
    start: DateTime.now,
    end: (DateTime.now.to_time - rand(3..8).hours).to_datetime,
    colony: colony,
    phase: 0)
  Event.create!(
    title: 'Monthly checkup',
    description: "Kitty roundup for the monthly checkup.",
    address: colony.address,
    start: DateTime.now,
    end: (DateTime.now.to_time - rand(3..8).hours).to_datetime,
    colony: colony,
    phase: 3)
end

puts 'All seeded!'
