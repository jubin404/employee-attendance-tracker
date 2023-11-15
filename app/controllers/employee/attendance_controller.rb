class Employee::AttendanceController < Employee::BaseController
  
  def index
    @attendance = Attendance.new
    @attendances = current_employee.attendances.page(params[:page]).order(created_at: :desc)
  end

  def new
    @attendance = Attendance.new
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def create
    @attendance = Attendance.new(attendance_params)
    @attendance[:employee_id] = current_employee[:id]
    @attendance[:status] = 'active'

    if @attendance.save
      flash[:notice] = "Attendance was added successfully."
      redirect_to attendance_index_path
    else
      flash[:notice] = "Something went wrong"
      render 'new'
    end
  end

  private

  def attendance_params 
    params.require(:attendance).permit(:attendance_status, :date, :punch_in_time, :punch_out_time)
  end
end
