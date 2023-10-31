class Attendance < ApplicationRecord

  belongs_to :employee

  validates :date, presence: true
  validate :punch_out_time_must_be_greater_than_punch_in_time

  def punch_out_time_must_be_greater_than_punch_in_time
    return if punch_in_time.nil? || punch_out_time.nil?

    if punch_out_time <= punch_in_time
      errors.add(:punch_out_time, 'must be greater than punch in time')
    end
  end

  def working_hours
    (punch_out_time - punch_in_time) / 3600
  end
end
