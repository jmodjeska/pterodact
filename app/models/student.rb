class Student < ActiveRecord::Base
    has_many :enrollments
    has_many :offer_dates, through: :enrollments
    has_many :courses, through: :offer_dates
    validates_presence_of :first_name, :last_name, :moz_number

    def full_name
      "#{self.first_name} #{self.last_name}"
    end
end
