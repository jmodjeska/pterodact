require 'rails_helper'

RSpec.feature 'Listing all students' do
    before do
        @user = FactoryGirl.create(:user)
        sign_in(@user)
    end

    scenario 'returns a message when there are no students to view', type: :feature do
        visit '/'
        click_link('Students', match: :first)
        expect(current_url).to eq(students_url)

        expect(page).to have_content('Home')
    end

    scenario "displays no students if there aren't any", type: :feature do
        visit '/'
        click_link('Students', match: :first)
        expect(current_url).to eq(students_url)

        expect(page).to have_content('0 students')
    end

    scenario 'displays the list of students', type: feature do
        visit '/'
        click_link('Students', match: :first)
        expect(current_url).to eq(students_url)

        # Student.destroy_all

        student1 = Student.create!(
            first_name: 'Ada',
            last_name: 'Lovelace',
            department: 'Engineering',
            moz_number: 1,
            manager_id: 14
        )
        student2 = Student.create!(
            first_name: 'Marshall',
            last_name: 'Sasquatch',
            department: 'E-Team',
            moz_number: 5,
            manager_id: 12
        )
        student3 = Student.create!(
            first_name: 'Pat',
            last_name: 'Fender',
            department: 'Marketing',
            moz_number: 11,
            manager_id: 3
        )

        visit '/'
        click_link('Students', match: :first)

        expect(current_url).to eq(students_url)
        expect(page).to have_content('3 students')
        expect(page).to have_content(student2.first_name)
        expect(page).to have_content(student2.last_name)
        expect(page).to have_content(student2.department)
        expect(page).to have_content(student2.moz_number)
        expect(page).to have_content(student2.manager_id)
    end
end
