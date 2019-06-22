# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u1 = User.create({
  username: 'user1',
  password: '11111',
  password_confirmation: '11111'
})
u2 = User.create({
  username: 'user2',
  password: '22222',
  password_confirmation: '22222'
})

u1.profile=Profile.new(full_name: 'User One', email: 'u1@boardgames.com')
u2.profile=Profile.new(full_name: 'User Two', email: 'u2@boardgames.com')