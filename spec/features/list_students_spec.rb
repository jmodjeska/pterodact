require 'rails_helper'

RSpec.feature 'Listing all students' do
    scenario 'returns a message when there are no students to view', type: :feature do
        visit '/'
        click_link 'Students'
        
        expect(page.current_url).to eq(students_url)
        expect(page).to have_content('0 students')
    end
end
