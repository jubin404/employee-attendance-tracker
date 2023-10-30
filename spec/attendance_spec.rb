require 'rails_helper'

describe Attendance do
  before do
    @address= Address.create(line_one: 'home')
    @gender= Gender.create(title: 'male')
    @employee= Employee.create(email: 'test@gmail.com', 
                               password: '123456', 
                               address_id: @address[:id],
                               first_name: 'first',
                               last_name: 'last', 
                               gender_id: @gender[:id],
                               employee_id: 'TM123')
    @attendance = Attendance.new(employee_id: @employee[:id], 
                                 date: '01-01-2023', 
                                 punch_in_time: '10:00 am', 
                                 punch_out_time: '6:00 pm',
                                 attendance_status: 'present')
    expect(@attendance.save).to eq true
  end

  it 'Employee id must be present' do
    @attendance.employee_id = nil
  end

  it 'Date must be present' do
    @attendance.date = nil
  end

  it 'Punch out time must be after punch in time' do
    @attendance.punch_in_time = '6:01 pm'
  end

  it 'Attendance entry must have a valid date' do
    @attendance.date = '31-02-2023'
  end
  
  after do
    expect(@attendance.save).to eq false
  end
end
