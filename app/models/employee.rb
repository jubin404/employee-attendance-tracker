class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, length: { minimum: 3 }
  validates :last_name, length: { minimum: 3 }
  validates :employee_id, format: { with: /\A\ATM/, message: "must start with 'TM'" }

  belongs_to :address 
  belongs_to :gender
  has_many :attendances

  def display_name
    "#{first_name} #{last_name}"
  end

  def display_id
    employee_id
  end
end
