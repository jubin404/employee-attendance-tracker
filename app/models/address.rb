class Address < ApplicationRecord

  has_many :employees
  validate :country_validation

  def country_validation
    return if country.nil?

    valid_country = ISO3166::Country.find_country_by_any_name(country)
    errors.add(:country, 'must have a valid country name') if valid_country.nil?
  end
  
end
