require 'rails_helper'

describe Employee do
  before do
    @employee = build(:employee)
  end

  it 'Employee instance must be created successfulyl with email, password, address and gender fields' do
    expect(@employee.save).to eq true
  end

  context 'Presence of attribute values of Employee model' do
    it 'Employee must have non-empty email' do
      @employee[:email] = nil
    end

    it 'Employee must have non-empty password' do
      @employee.password = nil
    end

    after do
      expect(@employee.save).to eq false
    end
  end

  context 'Constraints of attribute values of Employee model' do
    before do
      expect(@employee.save).to eq true
    end

    it 'Employee must have a valid email id' do
      @employee.email = 'test'
    end

    it 'Employee must have minimum of 3 characters in their first name' do
      @employee.first_name = '12'
    end

    it 'Employee must have minimum of 3 characters in their last name' do
      @employee.last_name = '12'
    end

    it 'Employee password must have a minimum strength of 6 characters' do
      @employee.password = '12345'
    end

    it 'Employee id must start with TM' do
      @employee.company_id = 'AM123'
    end

    after do
      expect(@employee.save).to eq false
    end
  end

  context 'When testing associations and methods of Employee model' do
    before do
      @employee.save
    end

    it 'Employee full name must be displayable' do
      expect(@employee.display_name).to eq "#{@employee[:first_name]} #{@employee[:last_name]}"
    end

    it 'Employee id must be displayable' do
      expect(@employee.display_id).to eq @employee[:company_id]
    end

    # it 'Employee address is linked to the right entry from address model' do
    #   expect(@employee.address[:line_one]).to  eq 'home'
    # end

    it 'Employee @addressis linked to the right gender from gender model' do
      expect(@employee.gender[:title]).to  eq 'male'
    end
  end

  context 'When testing methods of Employee model' do
    it 'Employee attendances are recorded successfully in attendance model' do
      create(:attendance)
      employee = Employee.first
      test_day = employee.attendances.select { |entry| entry[:date] == '01-01-2024'.to_date }
      expect(test_day.first[:attendance_status]).to  eq 'present'
    end
  end
end
