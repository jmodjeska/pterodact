require 'rails_helper'
require 'awesome_print'

RSpec.feature 'Importing a student CSV', type: :feature do

    before do
        @user = FactoryGirl.create(:user)
        sign_in(@user)
    end

    scenario 'succeeds with a conforming spreadsheet' do
        file_to_upload = Rails.root +
            'spec/fixtures/files/active_moz_employee_report_good.csv'

        visit '/students'

        # Create a student whose info will be updated following import
        student_to_update = Student.create!(
            first_name: 'Marion',
            last_name:  'Coatesworth-Hay',
            department: 'Not a real department',
            moz_number: 2,
            manager_id: 6000
        )

        # Prevent 'updated' and 'created' timestamps from matching
        sleep 1

        # Upload good CSV
        click_link('Import Students from File', match: :first)
        attach_file('fileInput', file_to_upload, visible: false)
        click_button('Start Import')

        # TODO: mark student inactive where Mozzer ID is absent from import

        # Verify import was successful: that two new students were added and
        # that one, Marion Coatesworth-Hay (moz_number: 2), was updated
        expect(current_url).to eq(students_url)
        expect(page).to have_content('2 new students and updated 1 students')

        # Verify uploaded students are present
        visit '/students'
        expect(page).to have_content('Captain Amazing')
        expect(page).to have_content('Excalibur McSandwichface')
        expect(page).to have_content('Marion Coatesworth-Hay')

        # # Verify Marion Coatesworth-Hay's manager and department were updated
        # click_link('Marion', match: :first)
        # expect(page).to have_content('5903')
        # expect(page).to have_content('Space')
    end

    # scenario 'fails if the spreadsheet is not properly formatted' do
    #     visit '/students'
    #     click_link('Import Students', match: :first)

    #     expect(current_url).to eq(import_student_url)

    #     # Import "bad" spreadsheet (missing columns)

    #     click_button 'Import Students'

    #     # Expected behavior: fail due to missing column

    #     expect(current_path).to eq(confirm_import_url)
    #     expect(page).to have_content('error')
    # end
end
