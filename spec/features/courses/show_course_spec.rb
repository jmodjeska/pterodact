require 'rails_helper'

RSpec.feature 'Viewing a course', type: :feature do
  before do
      @user = FactoryGirl.create(:user)
      sign_in(@user)
  end
      
  scenario 'shows the course details' do
    course = FactoryGirl.create(:course)

    visit course_url(course)

    expect(page).to have_content(course.name)
    expect(page).to have_content(course.catalog)
    expect(page).to have_content(course.description)
  end
  
  context 'with related data' do
    before(:all) do
      @course1 = FactoryGirl.create(:course)
      @course2 = FactoryGirl.create(:course)
      @course3 = FactoryGirl.create(:course)
    end

   scenario 'shows the course dates' do
      @course1.offer_dates.create(date: '2016-02-01', size: 4)
      @course1.offer_dates.create(date: '2016-03-05', size: 44)
      @course1.offer_dates.create(date: '2017-06-22', size: 90)
      
      visit course_url(@course1)
      
      expect(page).to have_content('2016-02-01')
      expect(page).to have_content('2016-03-05')
      expect(page).to have_content('2017-06-22')
    end
    
    scenario 'shows the course enrollments' do 
      student1 = FactoryGirl.create(:student)
      student2 = FactoryGirl.create(:student)
      student3 = FactoryGirl.create(:student)
      
      enrollment1 = Enrollment.create(course: @course1, student: student1)
      enrollment2 = Enrollment.create(course: @course1, student: student2)
      enrollment3 = Enrollment.create(course: @course1, student: student3)
      
      visit course_url(@course1)
      
      expect(page).to have_content(student1.first_name)
      expect(page).to have_content(student2.first_name)
      expect(page).to have_content(student3.first_name)
    end
  end
end
