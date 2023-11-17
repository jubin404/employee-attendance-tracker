class Attendance < ApplicationRecord

  belongs_to :employee

  validates :date, presence: true
  validates :attendance_status, presence: true
  validates_uniqueness_of :date, scope: :employee_id, message: ': Attendance has already been marked for this date.'

  validate :punch_out_time_must_be_greater_than_punch_in_time
  validate :attendance_status_valid_value
  validate :date_is_not_in_future
  validate :time_check_for_status
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

  def date_is_not_in_future
    errors.add(:date, 'is in future') if date > Date.today
  end

  def time_check_for_status
    if attendance_status.strip.downcase == 'absent'
      errors.add(:attendance_status, 'absent cannot take punching times') unless punch_in_time.nil? || punch_out_time.nil?
    else
      errors.add(:attendance_status, 'present must have punching times') if punch_in_time.nil? || punch_out_time.nil?
    end 
  end

  def downcase_attendance_status
    self.attendance_status.strip!.downcase!
 end

  def attendance_status_valid_value
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
