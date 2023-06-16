# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

10.times do |n|
  User.create!(
    name: "test#{n + 1}",
    email: "test#{n + 5}@example.com",
    password: "password",
    password_confirmation: "password"
  )
end

20.times do |m|
  Template.create(
    user: User.offset(rand(User.count)).first,
    name: "タイトル#{m + 1}",
    url: "https://be-notioner.com"
  )
end