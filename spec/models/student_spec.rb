require 'rails_helper'

RSpec.describe Student, type: :model do
    before(:all) do
        @student1 = FactoryGirl.build(:student)
    end

    it 'has a valid factory' do
        expect(@student1).to be_valid
    end

    it { is_expected.to have_db_column(:first_name) }
    it { is_expected.to have_db_column(:last_name) }
    it { is_expected.to have_db_column(:title) }
    it { is_expected.to have_db_column(:department) }
    it { is_expected.to have_db_column(:moz_number) }

    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
end