require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do 
      @user = FactoryGirl.build(:user)
  end

  it 'has a valid factory' do
      expect(@user).to be_valid
  end

  it { is_expected.to have_db_column(:name) }
  it { is_expected.to have_db_column(:email) }
  it { is_expected.to have_db_column(:password_digest) }
  
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to have_secure_password }
end