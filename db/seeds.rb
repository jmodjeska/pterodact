# Kill everything and reseed:
# RAILS_ENV=development rake db:drop db:create db:migrate db:seed

100.times do
    course = Course.create!(
        name: Faker::App.name,
        catalog: Faker::Lorem.characters(8).upcase,
        description: Faker::Company.catch_phrase,
    )
    3.times do
        course.offer_dates.create(date: Faker::Date.forward(180), size: rand(1..100))
    end
end

for i in 1..100
    Student.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        department: Faker::Commerce.department,
        moz_number: i + 60,
        manager_id: Faker::Number.number(4)
    )
end

for i in 1..100
    Enrollment.create!(
        offer_date_id: OfferDate.order("RANDOM()").first.id,
        student_id: Student.order("RANDOM()").first.id
    )
end

User.create!(
        name: 'Pterodactyl Jones',
        email: 'pterodact@example.com',
        password: 'pterodact',
        password_confirmation: 'pterodact'
)
