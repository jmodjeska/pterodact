require 'rails_helper'

RSpec.feature 'Listing all courses' do
    scenario 'returns a message when there are no courses to view' do
        visit '/'
        click_link 'Courses'

        expect(page.current_url).to eq(courses_url)
        expect(page).to have_content('0 courses')
    end
end
