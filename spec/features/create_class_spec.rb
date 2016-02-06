require 'rails_helper'

RSpec.feature 'Creating a new course', type: :feature do
    scenario 'succeeds with valid values' do
        visit '/courses'
        click_link('New Course', match: :first)

        expect(current_url).to eq(new_course_url)
        
        fill_in 'course_name', with: 'Aardwolf Course'
        fill_in 'course_catalog', with: 'XYZ1234'
        fill_in 'course_description', with: 'Learn how to live like a mad baller aardwolf'
        # Leaving offer_date and size blank on purpose
        click_button 'Create Course'

        expect(current_path).to eq(course_path(Course.last))
        expect(page).to have_content('Aardwolf Course')
        expect(page).to have_content('Course successfully created.')
    end

    scenario 'fails if the name is not provided' do
        visit '/courses'
        click_link('New Course', match: :first)
        
        expect(current_url).to eq(new_course_url)
        
        fill_in 'course_name', with: ''
        fill_in 'course_catalog', with: 'XYZ1234'
        fill_in 'course_description', with: 'Learn how to live like a mad baller aardwolf'
        # Leaving offer_date and size blank on purpose
        click_button 'Create Course'

        expect(current_path).to eq(new_course_path)
        expect(page).to have_content('error')
    end
end
