require 'rails_helper'

describe Attendance do

    it 'Punch out time must be after punch in time' do
      attendance = Attendance.create(date: '01-01-2023', punch_in_time: '10:00 am', punch_out_time: '6:00 pm')
      expect(attendance[:punch_out_time]).to be >= attendance[:punch_in_time]
    end

    it 'Attendance entry must have a valid date' do
      attendance = Attendance.create(date: '31-02-2023')
      expect(attendance.valid?).to eq(false)
    end
end
