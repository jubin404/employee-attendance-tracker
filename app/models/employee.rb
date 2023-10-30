class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, length: { mminimum: 3 }
  validates :last_name, length: { minimum: 3 }
  validates_format_of :employee_id, with: /^(TM)/

  belongs_to :address
  belongs_to :gender
  has_many :attendances
end
