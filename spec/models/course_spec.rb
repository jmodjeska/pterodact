require 'rails_helper'

RSpec.describe Course, type: :model do
    before(:all) do
        @course1 = FactoryGirl.build(:course)
    end

    it 'has a valid factory' do
        expect(@course1).to be_valid
    end

    it { is_expected.to have_db_column(:name) }
    it { is_expected.to have_db_column(:catalog) }
    it { is_expected.to have_db_column(:description) }
    it { is_expected.to have_db_column(:size) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:catalog) }
    it { is_expected.to validate_presence_of(:size) }
end