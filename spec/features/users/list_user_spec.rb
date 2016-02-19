require 'rails_helper'

RSpec.feature 'Listing all users', type: :feature do
  before do
    @user = FactoryGirl.create(:user)
    sign_in(@user)
  end
  
  context 'when users exist' do
    before(:all) do
      User.destroy_all
      @user1 = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @user3 = FactoryGirl.create(:user)
    end
    
    scenario 'displays the users' do 
      visit '/'
      click_link('Users', match: :first)
      
      expect(current_url).to eq(users_url)
      expect(page).to have_content('4 users')
      expect(page).to have_content(@user1.name)
      expect(page).to have_content(@user1.email)
      expect(page).to have_content(@user2.name)
      expect(page).to have_content(@user3.name)
    end
  end
end
