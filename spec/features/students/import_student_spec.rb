require 'rails_helper'

RSpec.feature 'Importing a student CSV', type: :feature do
    before do
        @user = FactoryGirl.create(:user)
        sign_in(@user)
    end

    scenario 'succeeds with a conforming spreadsheet' do
        visit '/students'
        click_link('Import Students', match: :first)

        expect(current_url).to eq(import_student_url)

        # Create a student whose info will be updated following import
        student_to_update = Student.create!(
            first_name: 'Marion',
            last_name:  'Coatesworth-Hay',
            department: 'Not a real department',
            moz_number: '0002',
            manager_id: '6000'
        )

        # Import "good" spreadsheet
        click_button 'Import Students'

        # Expected behavior:
        # UPDATE where Mozzer ID already exists in DB
        # CREATE where Mozzer ID doesn't exist in DB
        # TODO: mark inactive where Mozzer ID is absent from import

        # Verify import was successful
        expect(current_path).to eq(confirm_import_url)
        expect(page).to have_content('successfully imported.')

        # # Verify that first and last golden match Mozzer IDs are present in DB
        # visit '/students'
        # expect(page).to have_content('Captain Amazing')
        # expect(page).to have_content('Excalibur McSandwichface')
        # expect(page).to have_content('Marion Coatesworth-Hay')

        # # Verify that Marion Coatesworth-Hay's manager and department were updated
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
