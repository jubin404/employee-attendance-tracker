require 'rails_helper'

describe Gender do
  before do
    @employee = create(:employee)
  end

  context 'When testing methods of Gender model' do
    it 'Employee gender title must be displayable' do
      expect(@employee.gender.display_title).to eq Gender.first[:title]
    end
  end
end
