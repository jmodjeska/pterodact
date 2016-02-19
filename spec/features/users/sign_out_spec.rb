require 'rails_helper'

RSpec.feature 'Signing the user out of the application' do 
  scenario 'succeeds when the sign out link is clicked' do 
    @user = FactoryGirl.create(:user)
    
    sign_in(@user)
    
    click_link 'Sign Out'
    
    expect(current_path).to eq(landing_path)
    expect(page).to have_content('signed out')
  end
end
