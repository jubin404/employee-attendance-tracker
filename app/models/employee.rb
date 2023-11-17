class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  validates :first_name, length: { minimum: 3 }
  validates :last_name, length: { minimum: 3 }
  validates :company_id, format: { with: /\A\ATM/, message: "must start with 'TM'" }

  belongs_to :gender
  has_many :addresses
  has_many :attendances

  def display_name
    "#{first_name} #{last_name}"
  end

  def display_id
    company_id
  end

  def present_days_count
    self.attendances.select {|day| day[:attendance_status] == 'present' }.size
  end

  def absent_days_count
    self.attendances.select {|day| day[:attendance_status] == 'absent' }.size
  end

  def self.find_by_name(name)
    return [] if name.blank?

    first_name, last_name = name.split(' ', 2)

    if last_name.present?
      where("first_name LIKE ? AND last_name LIKE ?", "%#{first_name}%", "%#{last_name}%")
    else
      where("first_name LIKE ? OR last_name LIKE ?", "%#{first_name}%", "%#{first_name}%")
    end
  end
end
