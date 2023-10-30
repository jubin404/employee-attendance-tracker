require 'rails_helper'

describe Employee do
  before do
    @address= Address.create(line_one: 'home')
    @gender= Gender.create(title: 'male')
    @employee= Employee.new(email: 'test@gmail.com', 
                            password: '123456', 
                            address_id: @address[:id],
                            first_name: 'first',
                            last_name: 'last', 
                            gender_id: @gender[:id],
                            employee_id: 'TM123')
  end

  it 'Employee instance must be created successfulyl with email, password, address and gender fields' do
    expect(@employee.save).to eq true
  end

  context 'Presence of attribute values of Employee model' do
    it 'Employee must have non-empty email' do
      @employee[:email] = nil
    end

    it 'Employee must have non-empty password' do
      @employee.password = nil
    end

    it 'Employee must have non-empty adress' do
      @employee.address_id = nil
    end

    it 'Employee must have non-empty gender' do
      @employee.gender_id = nil
    end

    after do
      expect(@employee.save).to eq false
    end
  end

  context 'Constraints of attribute values of Employee model' do
    before do
      expect(@employee.save).to eq true
    end

    it 'Employee must have a valid email id' do
      @employee.email = 'test'
    end

    it 'Employee must have minimum of 3 characters in their first name' do
      @employee.first_name = '12'
    end

    it 'Employee must have minimum of 3 characters in their last name' do
      @employee.last_name = '12'
    end

    it 'Employee password must have a minimum strength of 6 characters' do
      @employee.password = '12345'
    end

    it 'Employee id must start with TM' do
      @employee.employee_id = 'AM123'
    end

    after do
      expect(@employee.save).to eq false
    end
  end

  context 'When testing associations of Employee model' do
    before do
      @employee.save
    end

    it 'Employee address is linked to the right entry from address model' do
      expect(@employee.address[:line_one]).to  eq 'home'
    end

    it 'Employee @addressis linked to the right gender from gender model' do
      expect(@employee.gender[:title]).to  eq 'male'
    end

    it 'Employee attendances are recorded successfully in attendance model' do
      Attendance.create(employee_id: @employee[:id], date: '01-01-2023', attendance_status: 'present')
      Attendance.create(employee_id: @employee[:id], date: '02-01-2023', attendance_status: 'absent')
      test_day = @employee.attendances.select { |entry| entry[:date] == '02-01-2023'.to_date }
      expect(test_day.first[:attendance_status]).to  eq 'absent'
    end
  end
end
