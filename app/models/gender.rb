class Gender < ApplicationRecord

  has_many :employees

  private

    def display_title 
    end
end
