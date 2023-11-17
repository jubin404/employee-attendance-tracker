class Attendance < ApplicationRecord

  belongs_to :employee

  validates :date, presence: true
  validate :punch_out_time_must_be_greater_than_punch_in_time
  validate :attendance_status_valid_value
  before_save :downcase_attendance_status


  scope :between_dates, ->(start_date, end_date) { where(date: start_date..end_date) }
  scope :today, -> { where(date: Date.today) }
  scope :with_present_status, -> { where(attendance_status: 'present') }

  def punch_out_time_must_be_greater_than_punch_in_time
    return if punch_in_time.nil? || punch_out_time.nil?

    if punch_out_time <= punch_in_time
      errors.add(:punch_out_time, 'must be greater than punch in time')
    end
  end

  def downcase_attendance_status
    self.attendance_status.downcase!
 end

  def attendance_status_valid_value
    return if attendance_status.nil?

    valid_values = ['present', 'absent']
    errors.add(:attendance_status, 'is not a valid value') unless valid_values.include?(attendance_status.downcase)
  end

  def working_hours
    return 0 if punch_out_time.nil?
    (punch_out_time - punch_in_time) / 3600 
  end

  def self.find_by_employee_name(name)
    return [] if name.blank?

    first_name, last_name = name.split(' ', 2)

    if last_name.present?
      joins(:employee).where("employees.first_name LIKE ? AND employees.last_name LIKE ?", "%#{first_name}%", "%#{last_name}%")
    else
      joins(:employee).where("employees.first_name LIKE ? OR employees.last_name LIKE ?", "%#{first_name}%", "%#{first_name}%")
    end
  end
end
