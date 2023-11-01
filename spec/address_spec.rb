require 'rails_helper'

describe Address do
  before do
    @address = build(:address)
    expect(@address.save).to eq true
  end

  it 'Valid country in address' do
    @address.country = 'djfdsf'
    expect(@address.save).to eq false
  end

  context 'When testing methods of Address model' do
    before do
      @address.save
      @employee = Employee.first
    end

    it 'Employee address must be displayable' do
      expect(@employee.addresses.first.display_address).to eq "#{@address[:line_one]}, #{@address[:country]}, #{@address[:pin]}"
    end
  end
end
