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
      @gender = create(:gender)
      @employee = create(:employee)
    end

    it 'Employee address must be displayable' do
      expect(@employee.address.display_address).to eq "#{@address[:line_one]}, #{@address[:country]}, #{@address[:pin]}"
    end
  end
end
