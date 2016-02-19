require 'rails_helper'

RSpec.feature 'Creating a new user', type: :feature do 
  before do
    @user = FactoryGirl.create(:user)
    sign_in(@user)
  end
  
  scenario 'succeeds with valid values' do 
    visit '/users'
    click_link 'New User' 
    
    expect(current_url).to eq(new_user_url)
    
    fill_in 'user_name', with: 'Test User' 
    fill_in 'user_email', with: 'test@test.com'
    fill_in 'user_password', with: 'secret'
    fill_in 'user_password_confirmation', with: 'secret'
    click_button 'Create User'
    
    # expect(current_path).to eq(user_path(User.last))
    expect(page).to have_content('Test User')
    expect(page).to have_content('test@test.com')
    expect(page).to have_content('User successfully created.')
  end
  
  it "does not save the user if it's invalid" do
    visit '/users'
    click_link 'New User'
    
    expect { 
      click_button 'Create User'
    }.not_to change(User, :count)
        
    expect(page).to have_text('error')
  end
end