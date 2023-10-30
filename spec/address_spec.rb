require 'rails_helper'

describe Address do
  before do
    @address = Address.new(line_one: 'home', country: 'india')
    expect(@address.save).to eq true
  end

  it 'Valid country in address' do
    @address.country = 'djfdsf'
    expect(@address.save).to eq false
  end
end
