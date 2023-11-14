class Employee::AttendanceController < Employee::BaseController
  
  def index
    @attendances = current_employee.attendances.page(params[:page]).order(created_at: :desc)
  end
end
