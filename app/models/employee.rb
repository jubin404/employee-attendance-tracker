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

  private 

  def display_name  #employee.displayename
    "#{first_name} #{last_name}"
  end

  
end
