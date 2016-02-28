class Course < ActiveRecord::Base
  has_many :offer_dates, dependent: :destroy  
  has_many :enrollments
  has_many :students, through: :enrollments
  validates_presence_of :name, :catalog
end
