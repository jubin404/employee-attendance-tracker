class Gender < ApplicationRecord

  has_many :employees

  def display_title
    title
  end
end
