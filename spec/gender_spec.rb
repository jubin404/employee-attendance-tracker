require 'rails_helper'

describe Gender do
  before do
    @address = Address.create(line_one: 'home', pin: '1234')
    @gender = Gender.create(title: 'male')
    @employee = Employee.create(email: 'test@gmail.com', 
                                password: '123456', 
                                address_id: @address[:id],
                                first_name: 'first',
                                last_name: 'last', 
                                gender_id: @gender[:id],
                                employee_id: 'TM123')
  end

  context 'When testing methods of Gender model' do
    it 'Employee gender title must be displayable' do
      expect(@employee.gender.display_title).to eq @gender[:title]
    end
  end
end
