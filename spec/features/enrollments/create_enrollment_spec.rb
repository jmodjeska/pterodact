require 'rails_helper'

def selector(form_id, option_id)
    within form_id do
      find("option[value='#{option_id}']").select_option
    end
end

RSpec.feature 'Creating a new enrollment', type: :feature do
    before do
        @user = FactoryGirl.create(:user)
        sign_in(@user)
    end
      
    before(:each) do
        FactoryGirl.create(:course)
        FactoryGirl.create(:student)
        
        Course.last.offer_dates.create(date: '2016-05-17', size: '14')
        @sid = Student.last.id.to_s
        @cid = Course.last.offer_dates.last.id.to_s
    end

    scenario 'succeeds with valid values' do
        visit '/enrollments'
        click_link('New Enrollment', match: :first)

        expect(current_path).to eq(new_enrollment_path)

        selector("#enrollment_offer_date_id", @cid)
        selector("#enrollment_student_id", @sid)
        click_button 'Create Enrollment'

        expect(current_path).to eq(enrollment_path(Enrollment.last))
        expect(page).to have_content('2016-05-17')
        expect(page).to have_content(@sid)
        expect(page).to have_content('Enrollment successfully created.')
    end

    scenario 'fails if the Course is not provided' do
        visit '/enrollments'
        click_link('New Enrollment', match: :first)
        
        expect(current_path).to eq(new_enrollment_path)

        selector("#enrollment_student_id", @sid)
        click_button 'Create Enrollment'

        expect(current_path).to eq(enrollments_path)
        expect(page).to have_content('error')
    end
end
