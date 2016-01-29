require 'rails_helper'

RSpec.describe 'Course', type: :model do
    it 'has a name field' do
        course1 = Course.new(name: 'Test Course')
        expect(course1.name).to eq('Test Course')
    end
    it 'has a catalog field' do
        
    end
    it 'has a description field' do
        
    end
    it 'has a offer_date field' do
        
    end
    it 'has a size field' do
        
    end
end