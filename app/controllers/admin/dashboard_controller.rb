class Admin::DashboardController < Admin::BaseController 
  
  def index 
    @employees = Employee.all
    @attendances = Attendance.all
  end
end
