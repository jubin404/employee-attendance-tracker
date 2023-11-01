FactoryBot.define do
  factory :employee do
    email { 'test@gmail.com' }
    password { '123456' }
    first_name { 'first' }
    last_name { 'last' }
    company_id { 'TM123' }
    association :gender, factory: :gender 
    association :address, factory: :address
  end
end
