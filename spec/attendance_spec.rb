require 'rails_helper'

describe Attendance do
  before do
    @attendance = build(:attendance)
  end

  it 'Attendance instance can be created with employee id and date fields' do
    expect(@attendance.save).to eq true
  end

  context 'Checking attendance model attribute values' do
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

  context 'When testing methods of Attendance model' do
    before do
      @attendance.save
    end

    it 'Employee working hours on any day must be displayable' do
      employee = Employee.first
      expect(employee.attendances.first.working_hours).to eq (@attendance[:punch_out_time] - @attendance[:punch_in_time]) / 3600
    end
  end
end
