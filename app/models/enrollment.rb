class Enrollment < ActiveRecord::Base
  belongs_to :offer_date
  belongs_to :student
  validates_presence_of :offer_date_id, :student_id
end