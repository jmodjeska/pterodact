require 'rails_helper'

RSpec.describe Task, type: :model do 
  it 'belongs to a course' do 
    course = FactoryGirl.create(:course)
    task = course.tasks.build(name: 'Test Task', due_date: '2/2/16')
    
    expect(task.course).to eq(course)
  end
end