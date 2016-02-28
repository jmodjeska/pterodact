require 'rails_helper'

RSpec.feature 'Creating a date', type: :feature do
    before do
        @user = FactoryGirl.create(:user)
        sign_in(@user)
    end
      
    scenario 'saves the date if it is valid and displays it on the Course page' do
        course = FactoryGirl.create(:course)
        
        visit course_url(course)
        click_link 'Add Offer Date'
        
        expect(current_path).to eq(new_course_offer_date_path(course))
        
        fill_in 'Date', with: '2016-02-22'
        fill_in 'Capacity', with: '21'
        click_button 'Create Offer Date'
        
        expect(current_path).to eq(course_offer_date_path(course, OfferDate.last))
        expect(page).to have_content(OfferDate.last.date)
    end
end