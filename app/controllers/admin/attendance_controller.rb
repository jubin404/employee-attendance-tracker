class Admin::AttendanceController < Admin::BaseController 
  before_action :set_attendance, only: [:edit, :update, :destroy]
  
  def index 
    @attendances = if params[:employee_name].present?
      Attendance.find_by_employee_name(params[:employee_name]).page(params[:page]).order(created_at: :desc)
    else
      Attendance.all.page(params[:page]).order(created_at: :desc)
    end

    respond_to do |format|
      format.html
      format.js 
    end
  end

  def new
    @attendance = Attendance.new
    @attendance_params = employee_attendance_params if adding_employee_attendance
  end

  def create
    @attendance = Attendance.new(attendance_params)
    @attendance[:status] = 'active'
    employee_from_company_id

    if @attendance.save
      flash[:notice] = "Attendance was added successfully."
      redirect_to admin_attendance_index_path
    else
      flash[:notice] = @attendance.errors.full_messages
      render 'new'
    end
  end

  def edit 
    @employee = Employee.find(@attendance[:employee_id])
  end

  def update
    if @attendance.update(attendance_update_params)
      flash[:notice] = "Attendance was updated successfully."
      redirect_to admin_attendance_index_path
    else
      render 'edit'
    end
  end

  def destroy
    @attendance.destroy
    redirect_to admin_attendance_index_path
  end

  private

  def attendance_params 
    params.require(:attendance).permit(:employee_id, :attendance_status, :date, :punch_in_time, :punch_out_time)
  end

  def attendance_update_params 
    params.require(:attendance).permit(:attendance_status, :date, :punch_in_time, :punch_out_time)
  end

  def employee_attendance_params
    params.require(:attendance).permit(:employee_id, :employee_name)
  end

  def adding_employee_attendance
    params.include?(:attendance)
  end

  def employee_from_company_id
    @attendance[:employee_id] = Employee.find_by(company_id: attendance_params[:employee_id])[:id]
  end

  def set_attendance
    @attendance = Attendance.find(params[:id])
  end
end
