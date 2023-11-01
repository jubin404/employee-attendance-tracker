class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
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
end
