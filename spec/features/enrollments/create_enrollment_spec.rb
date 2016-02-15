require 'rails_helper'

RSpec.feature 'Creating a new enrollment', type: :feature do

    before(:all) do
        2.times do
            FactoryGirl.create(:course)
            FactoryGirl.create(:student)
        end
    end

    scenario 'succeeds with valid values' do
        visit '/enrollments'
        click_link('New Enrollment', match: :first)

        expect(current_path).to eq(new_enrollment_path)
        
        fill_in 'enrollment_course_id', with: '1'
        fill_in 'enrollment_student_id', with: '2'
        click_button 'Create Enrollment'

        expect(current_path).to eq(enrollment_path(Enrollment.last))
        expect(page).to have_content('1')
        expect(page).to have_content('2')
        expect(page).to have_content('Enrollment successfully created.')
    end

    scenario 'fails if the Course is not provided' do
        visit '/enrollments'
        click_link('New Enrollment', match: :first)
        
        expect(current_path).to eq(new_enrollment_path)
        
        fill_in 'enrollment_course_id', with: ''
        fill_in 'enrollment_student_id', with: '2'
        click_button 'Create Enrollment'

        expect(current_path).to eq(enrollments_path)
        expect(page).to have_content('error')
    end
end
