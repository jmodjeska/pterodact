FactoryGirl.define do
    factory :course do
        name            { Faker::App.name }
        catalog         { Faker::Lorem.characters(8) }
        description     { Faker::Company.catch_phrase }
        offer_date      { Faker::Date.forward(21) }  
        size            { Faker::Number.number(2) }
   end
end