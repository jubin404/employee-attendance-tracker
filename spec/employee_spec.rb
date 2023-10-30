require 'rails_helper'

describe Employee do
  context 'When attribute values of Employee model' do
    it 'Employee model must be created successfulyl with email, password, address and gender fields' do
      address = Address.create(line_one: 'home')
      gender = Gender.create(title: 'male')
      employee = Employee.create(email: 'test@gmail.com', password: 'testing', address_id: address[:id], gender_id: gender[:id])
      expect(employee.valid?).to eq true
    end

    it 'Employee must have non-empty email' do
      employee = Employee.new(password: 'password', address_id: 1, gender_id: 1)
      expect(employee.save).to eq false
    end

    it 'Employee must have non-empty password' do
      employee = Employee.new(email: 'test@gmail.com', address_id: 1, gender_id: 1)
      expect(employee.save).to eq false
    end
    it 'Employee must have non-empty adress' do
      employee = Employee.new(email: 'test@gmail.com', password: 'password', gender_id: 1)
      expect(employee.save).to eq false
    end

    it 'Employee must have non-empty gender' do
      employee = Employee.new(email: 'test@gmail.com', password: 'password', address_id: 1)
      expect(employee.save).to eq false
    end

    it 'Employee must have minimum of 3 characters in their first name' do
      employee = Employee.new(first_name: 'aaa')
      expect(employee.first_name.size).to be > 2
    end

    it 'Employee must have minimum of 3 characters in their last name' do
      employee = Employee.new(last_name: 'aaa')
      expect(employee.last_name.size).to be > 2
    end

    it 'Employee password must have a minimum strength of 6 characters' do
      employee = Employee.new(password: 'passwo')
      expect(employee.password.size).to be > 5
    end

    it 'Employee id must start with TM' do
      employee = Employee.new(employee_id: 'TM101')
      expect(employee.employee_id.slice(0,2)).to eq 'TM'
    end
  end

  context 'When testing associations of Employee model' do
    it 'Employee address is linked to the right entry from address model' do
      address_01 = Address.create(line_one: 'home 01')
      address_02 = Address.create(line_one: 'home 02')
      employee = Employee.new(address_id: address_02[:id])
      expect(employee.address[:line_one]).to  eq 'home 02'
    end

    it 'Employee address is linked to the right gender from gender model' do
      gender_01 = Gender.create(title: 'male')
      gender_02 = Gender.create(title: 'female')
      employee = Employee.new(gender_id: gender_02[:id])
      expect(employee.gender[:title]).to  eq 'female'
    end

    it 'Employee attendances are recorded successfully in attendance model' do
      address = Address.create(line_one: 'home')
      gender = Gender.create(title: 'male')
      employee = Employee.create(email: 'test@gmail.com', password: 'testing', address_id: address[:id], gender_id: gender[:id])
      attendance_01 = Attendance.create(employee_id: employee[:id], date: '01-01-2023', attendance_status: 'present')
      attendance_02= Attendance.create(employee_id: employee[:id], date: '02-01-2023', attendance_status: 'absent')
      test_day = employee.attendances.select { |entry| entry[:date] == '02-01-2023'.to_date }
      expect(test_day.first[:attendance_status]).to  eq 'absent'
    end
  end
end
