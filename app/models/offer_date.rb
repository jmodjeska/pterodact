class OfferDate < ActiveRecord::Base
    belongs_to :course
    has_many :enrollments
    has_many :students, through: :enrollments
    validates_presence_of :date, :size

    def course_and_offer_date
      "#{self.course.name} (#{self.date})"
    end
end