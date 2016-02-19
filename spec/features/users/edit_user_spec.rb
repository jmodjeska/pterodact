require 'rails_helper'

RSpec.feature 'Editing a user', type: :feature do
  before do
    @user = FactoryGirl.create(:user)
    sign_in(@user)
  end
  
  scenario 'updates the user and shows the user updated details' do
    user = FactoryGirl.create(:user)
    
    visit user_url(user)
    
    click_link 'Edit User'
    
    expect(current_path).to eq(edit_user_path(user))
    expect(find_field('user_name').value).to eq(user.name)
    expect(find_field('user_email').value).to eq(user.email)
        
    fill_in 'user_name', with: 'Updated User Name'
    
    click_button 'Update User'
    
    expect(current_path).to eq(user_path(user))
    expect(page).to have_content('Updated User Name')
  end
  
  scenario 'fails to update the user if the name is blank' do
    user = FactoryGirl.create(:user)
    
    visit user_url(user)
    
    click_link 'Edit User'
    
    expect(current_path).to eq(edit_user_path(user))
    expect(find_field('user_name').value).to eq(user.name)
    expect(find_field('user_email').value).to eq(user.email)
        
    fill_in 'user_name', with: ''
    
    click_button 'Update User'
    
    expect(current_path).to eq(user_path(user))
    expect(page).to have_content('error')
  end
  
  scenario 'fails to update the user if the email is blank' do
    user = FactoryGirl.create(:user)
    
    visit user_url(user)
    
    click_link 'Edit User'
    
    expect(current_path).to eq(edit_user_path(user))
    expect(find_field('user_name').value).to eq(user.name)
    expect(find_field('user_email').value).to eq(user.email)
        
    fill_in 'user_email', with: ''
    
    click_button 'Update User'
    
    expect(current_path).to eq(user_path(user))
    expect(page).to have_content('error')
  end
  
  scenario 'fails to update the user if the email is not unique' do
    existing_user = FactoryGirl.create(:user, email: 'test@test.com')
    user = FactoryGirl.create(:user)
    
    visit user_url(user)
    
    click_link 'Edit User'
    
    expect(current_path).to eq(edit_user_path(user))
    expect(find_field('user_name').value).to eq(user.name)
    expect(find_field('user_email').value).to eq(user.email)
        
    fill_in 'user_email', with: 'test@test.com'
    
    click_button 'Update User'
    
    expect(current_path).to eq(user_path(user))
    expect(page).to have_content('error')
  end
  
  scenario 'fails to update the user if the email is invalid' do
    user = FactoryGirl.create(:user)
    
    visit user_url(user)
    
    click_link 'Edit User'
    
    expect(current_path).to eq(edit_user_path(user))
    expect(find_field('user_name').value).to eq(user.name)
    expect(find_field('user_email').value).to eq(user.email)
        
    fill_in 'user_email', with: 'bogus'
    
    click_button 'Update User'
    
    expect(current_path).to eq(user_path(user))
    expect(page).to have_content('error')
  end
  
end