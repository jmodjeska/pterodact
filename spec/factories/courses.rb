FactoryGirl.define do
    factory :course do
        name            { Faker::App.name }
        catalog         { Faker::Lorem.characters(8) }
        description     { Faker::Company.catch_phrase }
   end
end