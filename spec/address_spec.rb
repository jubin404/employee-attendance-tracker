require 'rails_helper'

describe Address do
  before do
    @address = Address.new(line_one: 'home', country: 'india', pin: '1234')
    expect(@address.save).to eq true
  end

  it 'Valid country in address' do
    @address.country = 'djfdsf'
    expect(@address.save).to eq false
  end

  context 'When testing methods of Address model' do
    before do
      @address.save
      @gender = Gender.create(title: 'male')
      @employee = Employee.create(email: 'test@gmail.com', 
                                  password: '123456', 
                                  address_id: @address[:id],
                                  first_name: 'first',
                                  last_name: 'last', 
                                  gender_id: @gender[:id],
                                  employee_id: 'TM123')
    end

    it 'Employee address must be displayable' do
      expect(@employee.address.display_address).to eq "#{@address[:line_one]}, #{@address[:country]}, #{@address[:pin]}"
    end
  end
end
