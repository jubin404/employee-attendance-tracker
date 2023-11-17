class Admin::DashboardController < Admin::BaseController 
  
  def index 
    @employees = Employee.all
    @present_employees = @employees.with_present_attendance_today
    @attendances = Attendance.all
  end
end
