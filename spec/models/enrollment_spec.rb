require 'rails_helper'

RSpec.describe Enrollment do 
  it { is_expected.to have_db_column(:offer_date_id) }
  it { is_expected.to have_db_column(:student_id) }
  
  it { is_expected.to belong_to(:offer_date) }
  it { is_expected.to belong_to(:student) }
  
  it { is_expected.to validate_presence_of(:offer_date_id) }
  it { is_expected.to validate_presence_of(:student_id) }
end
