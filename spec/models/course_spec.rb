require 'rails_helper'

RSpec.describe 'Course', type: :model do
    before(:each) do
        @course1 = Course.new(
            name: 'Test Course',
            catalog: 'TEST5555',
            description: 'This is a test description.',
            offer_date: '2016-02-22',
            size: 10
        )
    end

    it 'has a name field' do
        expect(@course1.name).to eq('Test Course')
    end
    it 'has a catalog field' do
        expect(@course1.catalog).to eq('TEST5555')
    end
    it 'has a description field' do
        expect(@course1.description).to eq('This is a test description.')        
    end
    it 'has a offer_date field' do
        expect(@course1.offer_date).to eq('2016-02-22')        
    end
    it 'has a size field' do
        expect(@course1.size).to eq(10)        
    end
end