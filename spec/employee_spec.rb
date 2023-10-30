require 'rails_helper'

describe Employee do
  context 'When attribute values of Employee model' do
    it 'Employee model must be created successfulyl with email, password, address and gender fields' do
      address = Address.create(line_one: 'home')
      gender = Gender.create(title: 'male')
      employee = Employee.create(email: 'test@gmail.com', 
                                 password: 'testing', 
                                 address_id: address[:id],
                                 first_name: 'first',
                                 last_name: 'last', 
                                 gender_id: gender[:id],
                                 employee_id: 'TM101')
      expect(employee.valid?).to eq true
    end

    it 'Employee must have non-empty email' do
      address = Address.create(line_one: 'home')
      gender = Gender.create(title: 'male')
      employee = Employee.create(password: 'testing', 
                                 address_id: address[:id],
                                 first_name: 'first',
                                 last_name: 'last', 
                                 gender_id: gender[:id],
                                 employee_id: 'TM101')
      expect(employee.valid?).to eq false
    end

    it 'Employee must have non-empty password' do
      address = Address.create(line_one: 'home')
      gender = Gender.create(title: 'male')
      employee = Employee.create(email: 'test@gmail.com', 
                                 address_id: address[:id],
                                 first_name: 'first',
                                 last_name: 'last', 
                                 gender_id: gender[:id],
                                 employee_id: 'TM101')
      expect(employee.valid?).to eq false
    end
    it 'Employee must have non-empty adress' do
      gender = Gender.create(title: 'male')
      employee = Employee.create(email: 'test@gmail.com', 
                                 password: 'testing', 
                                 first_name: 'first',
                                 last_name: 'last', 
                                 gender_id: gender[:id],
                                 employee_id: 'TM101')
      expect(employee.valid?).to eq false
    end

    it 'Employee must have non-empty gender' do
      address = Address.create(line_one: 'home')
      employee = Employee.create(email: 'test@gmail.com', 
                                 password: 'testing', 
                                 first_name: 'first',
                                 last_name: 'last', 
                                 employee_id: 'TM101')
      expect(employee.valid?).to eq false
    end

    it 'Employee must have minimum of 3 characters in their first name' do
      address = Address.create(line_one: 'home')
      gender = Gender.create(title: 'male')
      employee_01 = Employee.create(email: 'test@gmail.com', 
                                    password: 'testing', 
                                    first_name: 'first',
                                    last_name: 'last', 
                                    address_id: address[:id],
                                    gender_id: gender[:id],
                                    employee_id: 'TM101')
      employee_02 = Employee.create(email: 'test02@gmail.com', 
                                    password: 'test', 
                                    first_name: 'fi',
                                    last_name: 'last', 
                                    address_id: address[:id],
                                    gender_id: gender[:id],
                                    employee_id: 'TM102')
      expect(employee_01.valid?).to eq true                         
      expect(employee_02.valid?).to eq false  
    end

    it 'Employee must have minimum of 3 characters in their last name' do
      address = Address.create(line_one: 'home')
      gender = Gender.create(title: 'male')
      employee_01 = Employee.create(email: 'test@gmail.com', 
                                    password: 'testing', 
                                    first_name: 'first',
                                    last_name: 'last', 
                                    address_id: address[:id],
                                    gender_id: gender[:id],
                                    employee_id: 'TM101')
      employee_02 = Employee.create(email: 'test02@gmail.com', 
                                    password: 'test', 
                                    first_name: 'first',
                                    last_name: 'la', 
                                    address_id: address[:id],
                                    gender_id: gender[:id],
                                    employee_id: 'TM102')
      expect(employee_01.valid?).to eq true                         
      expect(employee_02.valid?).to eq false  
    end

    it 'Employee password must have a minimum strength of 6 characters' do
      address = Address.create(line_one: 'home')
      gender = Gender.create(title: 'male')
      employee_01 = Employee.create(email: 'test@gmail.com', 
                                    password: 'testing', 
                                    first_name: 'first',
                                    last_name: 'last', 
                                    address_id: address[:id],
                                    gender_id: gender[:id],
                                    employee_id: 'TM101')
      employee_02 = Employee.create(email: 'test02@gmail.com', 
                                    password: 'test', 
                                    first_name: 'first',
                                    last_name: 'last', 
                                    address_id: address[:id],
                                    gender_id: gender[:id],
                                    employee_id: 'TM102')
      expect(employee_01.valid?).to eq true                         
      expect(employee_02.valid?).to eq false  
    end

    it 'Employee id must start with TM' do
      address = Address.create(line_one: 'home')
      gender = Gender.create(title: 'male')
      employee_01 = Employee.create(email: 'test@gmail.com', 
                                    password: 'testing', 
                                    first_name: 'first',
                                    last_name: 'last', 
                                    address_id: address[:id],
                                    gender_id: gender[:id],
                                    employee_id: 'TM101')
      employee_02 = Employee.create(email: 'test02@gmail.com', 
                                    password: 'testing', 
                                    first_name: 'first',
                                    last_name: 'last', 
                                    address_id: address[:id],
                                    gender_id: gender[:id],
                                    employee_id: 'AM101')
      expect(employee_01.valid?).to eq true                         
      expect(employee_02.valid?).to eq false                         
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
      employee = Employee.create(email: 'test@gmail.com', 
                                 password: 'testing', 
                                 first_name: 'first',
                                 last_name: 'last', 
                                 address_id: address[:id],
                                 gender_id: gender[:id],
                                 employee_id: 'TM101')
      attendance_01 = Attendance.create(employee_id: employee[:id], date: '01-01-2023', attendance_status: 'present')
      attendance_02= Attendance.create(employee_id: employee[:id], date: '02-01-2023', attendance_status: 'absent')
      test_day = employee.attendances.select { |entry| entry[:date] == '02-01-2023'.to_date }
      expect(test_day.first[:attendance_status]).to  eq 'absent'
    end
  end
end
