class Enrollment < ActiveRecord::Base
  belongs_to :course
  belongs_to :student

  validates_presence_of :course_id, :student_id
end