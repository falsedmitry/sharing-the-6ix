# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.destroy_all

dmitry = User.create(name: "Dmitry", email: "dmitry@gmail.com", password: "test", password_confirmation: "test", location: "Dundas", photo: "no photo")

alex = User.create(name: "Alex", email: "alex@gmail.com", password: "test", password_confirmation: "test", location: "King", photo: "no photo")

debbie = User.create(name: "Debbie", email: "debbie@gmail.com", password: "test", password_confirmation: "test", location: "Junction", photo: "no photo")

bill = User.create(name: "Bill", email: "bill@gmail.com", password: "test", password_confirmation: "test", location: "Markham", photo: "no photo")
