class Student < ActiveRecord::Base
    has_many :enrollments
    has_many :courses, through: :enrollments
    
    validates_presence_of :first_name, :last_name
end
