require 'rails_helper'

RSpec.feature 'Creating a new enrollment', type: :feature do

    before(:each) do
        # Course.destroy_all
        # Student.destroy_all

        rand(2..10).times do
            FactoryGirl.create(:course)
            FactoryGirl.create(:student)
        end

        @sid = Student.last.id.to_s
        @cid = Course.last.id.to_s
    end

    scenario 'succeeds with valid values' do
        visit '/enrollments'
        click_link('New Enrollment', match: :first)

        expect(current_path).to eq(new_enrollment_path)

        fill_in 'enrollment_course_id', with: @cid
        fill_in 'enrollment_student_id', with: @sid
        click_button 'Create Enrollment'

        expect(current_path).to eq(enrollment_path(Enrollment.last))
        expect(page).to have_content(@cid)
        expect(page).to have_content(@sid)
        expect(page).to have_content('Enrollment successfully created.')
    end

    scenario 'fails if the Course is not provided' do
        visit '/enrollments'
        click_link('New Enrollment', match: :first)
        
        expect(current_path).to eq(new_enrollment_path)
        
        fill_in 'enrollment_course_id', with: ''
        fill_in 'enrollment_student_id', with: @sid
        click_button 'Create Enrollment'

        expect(current_path).to eq(enrollments_path)
        expect(page).to have_content('error')
    end
end
