class Course < ActiveRecord::Base
  has_many :enrollments
  has_many :students, through: :enrollments
  
  validates_presence_of :name, :catalog, :size
end
