FactoryBot.define do
  factory :address do
    line_one { 'home' }
    country { 'india' }
    pin { '1234' }
    association :employee, factory: :employee
  end
end
