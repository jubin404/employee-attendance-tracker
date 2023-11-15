class Employee::DashboardController < Employee::BaseController
  
  def index
    @attendances = current_employee.attendances
  end
end
