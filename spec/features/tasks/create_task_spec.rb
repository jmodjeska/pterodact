require 'rails_helper'

RSpec.feature 'Creating a task', type: :feature do
    scenario 'saves the task if it is valid and displays it on the course page' do
        course = FactoryGirl.create(:course)
        
        visit course_url(course)
        click_link 'Add Task'
        
        expect(current_path).to eq(new_course_task_path(course))
        
        fill_in 'Name', with: 'Test task one'
        fill_in 'Due date', with: '2/2/16'
        click_button 'Create Task'
        
        expect(current_path).to eq(course_task_path(course, Task.last))
        expect(page).to have_content('Test task one')
        expect(page).to have_content(Task.last.due_date)
    end
end
