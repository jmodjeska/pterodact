# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do
    Course.create(
        name: Faker::App.name,
        catalog: Faker::Lorem.characters(8),
        description: Faker::Company.catch_phrase,
        offer_date: Faker::Date.forward(21),
        size: Faker::Number.number(2)
    )
end
