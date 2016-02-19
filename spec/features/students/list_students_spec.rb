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
            title: 'Generic Director of Strategic Innovention', 
            department: 'Engineering',
            moz_number: 1
        )
        student2 = Student.create!(
            first_name: 'Marshall', 
            last_name: 'Sasquatch',
            title: 'Vice President of East Coast Television and Microwave Oven Programming', 
            department: 'E-Team',
            moz_number: 5
        )
        student3 = Student.create!(
            first_name: 'Pat', 
            last_name: 'Fender',
            title: 'Early Adopter', 
            department: 'Marketing',
            moz_number: 11
        )
        
        visit '/'
        click_link('Students', match: :first)
        
        expect(current_url).to eq(students_url)
        expect(page).to have_content('3 students')
        expect(page).to have_content(student2.first_name)
        expect(page).to have_content(student2.last_name)
        expect(page).to have_content(student2.title)
        expect(page).to have_content(student2.department)
        expect(page).to have_content(student2.moz_number)
    end
end
