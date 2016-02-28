
100.times do
    Course.create(
        name: Faker::App.name,
        catalog: Faker::Lorem.characters(8).upcase,
        description: Faker::Company.catch_phrase,
    )
end

100.times do
    Student.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        title: Faker::Name.title,
        department: Faker::Commerce.department,
        moz_number: Faker::Number.number(3)

    )
end

User.create(
        name: 'Aardwolf Jones',
        email: 'aardwolf@daqron.com',
        password: 'aardwolf',
        password_confirmation: 'aardwolf' 
)