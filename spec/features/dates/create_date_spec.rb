require 'rails_helper'

RSpec.feature 'Creating a new course offering date', type: :feature do
    before do
        @user = FactoryGirl.create(:user)
        sign_in(@user)
    end
      
    before(:each) do
        rand(2..10).times do
            FactoryGirl.create(:course)
        end

        @offer_date = Faker::Date.forward(21)
        @cid = Course.last.name.to_s
    end

    scenario 'succeeds with valid values' do
        visit '/dates'
        click_link('New Date', match: :first)

        expect(current_path).to eq(new_date_path)

        select @cid, from: "date_course_id"
        fill_in 'date_date', with: @offer_date

        click_button 'Create Date'

        expect(current_path).to eq(dates_path(Date.last))
        expect(page).to have_content(@cid)
        expect(page).to have_content(@offer_date)
        expect(page).to have_content('date successfully added')
    end

    scenario 'fails if the Course is not provided' do
        visit '/dates'
        click_link('New Date', match: :first)
        
        expect(current_path).to eq(new_date_path)
        
        fill_in 'date_date', with: @offer_date

        click_button 'Create Date'

        expect(current_path).to eq(dates_path)
        expect(page).to have_content('error')
    end
end
