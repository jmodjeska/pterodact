require 'rails_helper'

RSpec.feature 'Creating a new course', type: :feature do
    before do
        @user = FactoryGirl.create(:user)
        sign_in(@user)
    end

    scenario 'succeeds with valid values' do
        visit '/courses'
        click_link('New Course', match: :first)

        expect(current_path).to eq(new_course_path)

        fill_in 'course_name', with: 'Aardwolf Course'
        fill_in 'course_catalog', with: 'XYZ1234'
        fill_in 'course_description', with: 'Learn how to live like a mad baller aardwolf'
        click_button 'Create Course'

        expect(current_path).to eq(course_path(Course.last))
        expect(page).to have_content('Aardwolf Course')
        expect(page).to have_content('Course successfully created.')
    end

    scenario 'fails if the name is not provided' do
        visit '/courses'
        click_link('New Course', match: :first)

        expect(current_path).to eq(new_course_path)

        fill_in 'course_name', with: ''
        fill_in 'course_catalog', with: 'XYZ1234'
        fill_in 'course_description', with: 'Learn how to live like a mad baller aardwolf'
        click_button 'Create Course'

        expect(current_path).to eq(courses_path)
        expect(page).to have_content('error')
    end
end
