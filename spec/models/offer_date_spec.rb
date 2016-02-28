require 'rails_helper'

RSpec.describe OfferDate, type: :model do 
  it 'belongs to a course' do 
    course = FactoryGirl.create(:course)
    offer_date = course.offer_dates.build(date: '2016-02-22', size: '16')
    expect(offer_date.course).to eq(course)
  end
end
