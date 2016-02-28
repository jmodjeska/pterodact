require 'rails_helper'

RSpec.feature 'Loading all courses' do
    before do
        @user = FactoryGirl.create(:user)
        sign_in(@user)
    end
      
    scenario "displays no courses if there aren't any", type: :feature do

        Course.destroy_all

        visit '/'
        click_link('Courses', match: :first)
        expect(current_url).to eq(courses_url)

        expect(page).to have_content('0 courses')
    end

    scenario 'displays the available courses', type: :feature do

        Course.destroy_all

        visit '/'
        click_link('Courses', match: :first)
        expect(current_url).to eq(courses_url)

        course1 = Course.create!(
            name: 'Test Course 1', 
            catalog: 'TEST1234', 
            description: 'Amazing course that teaches you stuff.', 
            size: 16
        )
        course2 = Course.create!(
            name: 'Test Course 2', 
            catalog: 'TEST5678', 
            description: 'Amazing course that teaches you things.', 
            size: 16
        )
        course3 = Course.create!(
            name: 'Test Course 3', 
            catalog: 'TEST3333', 
            description: 'Lame course that teaches you nothing.', 
            size: 16
        )
        
        visit '/'
        click_link('Courses', match: :first)
        
        expect(current_url).to eq(courses_url)
        expect(page).to have_content('3 courses')
        expect(page).to have_content(course2.name)
        expect(page).to have_content(course2.catalog)
        expect(page).to have_content(course2.description)
        expect(page).to have_content(course2.offer_date)
        expect(page).to have_content(course2.size)
    end
end
