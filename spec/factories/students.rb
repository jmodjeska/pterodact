FactoryGirl.define do
    factory :student do
        first_name      { Faker::Name.first_name }
        last_name       { Faker::Name.last_name }
        department      { Faker::Commerce.department }
        moz_number      { Faker::Number.number(3) }
        manager_id      { Faker::Number.number(2) }
   end
end
