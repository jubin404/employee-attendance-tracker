class Admin::AttendanceController < Admin::BaseController 
  before_action :set_attendance, only: [:edit, :update, :destroy]
  
  def index 
    @attendances = Attendance.all
    @attendances = filter_by_name(@attendances)
    @attendances = filter_by_date(@attendances).page(params[:page]).order(created_at: :desc)
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

  def export 
    @attendances = Attendance.all
    @attendances = filter_by_name(@attendances)
    @attendances = filter_by_date(@attendances)
    @attendances_csv = make_csv(@attendances)

    respond_to do |format|
      format.html
      format.csv { send_data @attendances_csv, filename: "attendance_list.csv" }
    end
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

  def filter_by_date(attendances)
    return attendances unless params[:start_date].present? && params[:end_date].present?

    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])

    attendances.between_dates(start_date, end_date)
  end

  def filter_by_name(attendances)
    return attendances unless params[:employee_name].present?
    
    attendances.find_by_employee_name(params[:employee_name])
  end

  def make_csv(attendances)
    attributes = %w[id employee_id date punch_in_time punch_out_time attendance_status]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      attendances.each do |attendance|
        csv << attributes.map { |attribute| attendance.send(attribute) }
      end
    end
  end
end
