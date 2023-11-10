class Admin::AttendanceController < ApplicationController 
  
  def index 
    @attendances = Attendance.all
  end

  def new
    @attendance = Attendance.new
    @attendance_params = employee_attendance_params
  end

  def create
    @attendance = Attendance.new(attendance_params)
    if @attendance.save
      flash[:notice] = "Attendance was added successfully."
      redirect_to admin_attendance_index_path
    else
      flash[:notice] = "Something went wrong"
      render 'new'
    end
  end

  private

  def attendance_params 
    params.require(:attendance).permit(:employee_id, :attendance_status, :date, :punch_in_time, :punch_out_time, :status)
  end

  def employee_attendance_params
    params.require(:attendance).permit(:employee_id, :employee_name)
  end
end
