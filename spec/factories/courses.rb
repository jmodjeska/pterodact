FactoryGirl.define do
    factory :course do
        name            { Faker::App.name }
        catalog         { Faker::Lorem.characters(8) }
        description     { Faker::Company.catch_phrase }
        size            { Faker::Number.number(2) }
   end
end