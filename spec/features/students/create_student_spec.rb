require 'rails_helper'

RSpec.feature 'Creating a new student', type: :feature do
    before do
        @user = FactoryGirl.create(:user)
        sign_in(@user)
    end

    scenario 'succeeds with valid values' do
        visit '/students'
        click_link('New Student', match: :first)

        expect(current_url).to eq(new_student_url)

        fill_in 'student_first_name', with: 'Wolfgang'
        fill_in 'student_last_name', with: 'Cumberbach'
        fill_in 'student_department', with: 'Exitential Moose Fashion Regulation'
        fill_in 'student_moz_number', with: '123'
        fill_in 'student_manager_id', with: '15'
        click_button 'Create Student'

        expect(current_path).to eq(student_path(Student.last))
        expect(page).to have_content('Wolfgang')
        expect(page).to have_content('successfully created.')
    end

    scenario 'fails if the first and last name are not provided' do
        visit '/students'
        click_link('New Student', match: :first)

        expect(current_url).to eq(new_student_url)

        fill_in 'student_first_name', with: ''
        fill_in 'student_last_name', with: ''
        click_button 'Create Student'

        expect(current_path).to eq(students_path)
        expect(page).to have_content('error')
    end
end
