require 'rails_helper'

RSpec.describe Enrollment do 
  it { is_expected.to have_db_column(:course_id) }
  it { is_expected.to have_db_column(:student_id) }
  
  it { is_expected.to belong_to(:course) }
  it { is_expected.to belong_to(:student) }
  
  it { is_expected.to validate_presence_of(:course_id) }
  it { is_expected.to validate_presence_of(:student_id) }
end