require 'rails_helper'

describe Employee do

  it 'Employee must have non-empty email' do
    employee = Employee.new(password: 'password', address_id: 1, gender_id: 1)
    expect(employee.valid?).to eq(false)
  end

  it 'Employee must have non-empty password' do
    employee = Employee.new(email: 'test@gmail.com', address_id: 1, gender_id: 1)
    expect(employee.valid?).to eq(false)
  end
  it 'Employee must have non-empty adress' do
    employee = Employee.new(email: 'test@gmail.com', password: 'password', gender_id: 1)
    expect(employee.valid?).to eq(false)
  end

  it 'Employee must have non-empty gender' do
    employee = Employee.new(email: 'test@gmail.com', password: 'password', address_id: 1)
    expect(employee.valid?).to eq(false)
  end

  it 'Employee must have minimum of 3 characters in their first name' do
    employee = Employee.new(first_name: 'aaa')
    expect(employee.first_name.size > 2).to eq(true)
  end

  it 'Employee must have minimum of 3 characters in their last name' do
    employee = Employee.new(last_name: 'aaa')
    expect(employee.last_name.size > 2).to eq(true)
  end

  it 'Employee password must have a minimum strength of 6 characters' do
    employee = Employee.new(password: 'passwo')
    expect(employee.password.size > 5).to eq(true)
  end

  it 'Employee id must start with TM' do
    employee = Employee.new(employee_id: 'TM101')
    expect(employee.employee_id.slice(0,2)).to eq('TM')
  end
end
