require 'rails_helper'

RSpec.describe 'Student', type: :model do
    before(:each) do
        @student1 = Student.new(
            first_name: 'TestFirst',
            last_name: 'TestLast',
            title: 'Director of Test',
            department: 'Test Engineering',
            moz_number: 101
        )
    end

    it 'has a first name field' do
        expect(@student1.first_name).to eq('TestFirst')
    end
    it 'has a last name field' do
        expect(@student1.last_name).to eq('TestLast')
    end
    it 'has a title field' do
        expect(@student1.title).to eq('Director of Test')        
    end
    it 'has a department field' do
        expect(@student1.department).to eq('Test Engineering')        
    end
    it 'has a moz_number field' do
        expect(@student1.moz_number).to eq(101)        
    end
end