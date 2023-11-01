class Address < ApplicationRecord

  belongs_to :employee
  validates :pin, presence: true
  validate :country_validation

  def country_validation
    return if country.nil?

    valid_country = ISO3166::Country.find_country_by_any_name(country)
    errors.add(:country, 'must have a valid country name') if valid_country.nil?
  end
  
  def display_address
    [line_one, line_two, city, country, pin].reject(&:nil?).join(", ")
  end
end
