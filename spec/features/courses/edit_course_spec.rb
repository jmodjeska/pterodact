require 'rails_helper'

RSpec.feature 'Editing a course', type: :feature do
  
  scenario 'updates and shows the course details' do
    course = FactoryGirl.create(:course)
    
    visit course_url(course)
    
    click_link 'Edit Course'
    
    expect(current_path).to eq(edit_course_path(course))
    expect(find_field('Name').value).to eq(course.name)

    fill_in 'Name', with: 'Updated course name'
    
    click_button 'Update Course'
    
    expect(current_path).to eq(course_path(course))
    expect(page).to have_content('Updated course name')
  end
  
end