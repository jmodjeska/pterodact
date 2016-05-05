
100.times do
    course = Course.create(
        name: Faker::App.name,
        catalog: Faker::Lorem.characters(8).upcase,
        description: Faker::Company.catch_phrase,
    )
    3.times do
        course.offer_dates.create(date: Faker::Date.forward(180), size: rand(1..100))
    end
end

100.times do
    Student.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        department: Faker::Commerce.department,
        moz_number: Faker::Number.number(3),
        manager_id: Faker::Number.number(4)
    )
end

for i in 1..100
    Enrollment.create(
        offer_date_id: i,
        student_id: i
    )
end

User.create(
        name: 'Aardwolf Jones',
        email: 'aardwolf@example.com',
        password: 'aardwolf',
        password_confirmation: 'aardwolf'
)
