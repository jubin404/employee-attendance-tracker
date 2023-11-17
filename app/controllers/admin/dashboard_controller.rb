class Admin::DashboardController < Admin::BaseController 
  
  def index 
    @attendances = Attendance.all
    @employees = Employee.all
    @present_employees = @employees.with_present_attendance_today
    @absent_employees_count = @employees.count - @present_employees.count
  end
end
