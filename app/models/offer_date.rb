class OfferDate < ActiveRecord::Base
    belongs_to :course
    validates_presence_of :date, :size
end