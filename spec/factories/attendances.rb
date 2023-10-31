FactoryBot.define do
  factory :attendance do
    date { '01-01-2024' }
    attendance_status { 'present' }
    punch_in_time { '10:00 am' }
    punch_out_time { '6:00 pm' }
    association :employee, factory: :employee
  end
end
