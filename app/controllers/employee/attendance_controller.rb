class Employee::AttendanceController < Employee::BaseController
  require 'csv'

  def index
    @attendance = Attendance.new
    @attendances = current_employee.attendances.page(params[:page]).order(created_at: :desc)

    if params[:start_date].present? && params[:end_date].present?
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])

      @attendances = @attendances.between_dates(start_date, end_date).page(params[:page]).order(created_at: :desc)
    end
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
      flash[:notice] = @attendance.errors.full_messages
      render 'new'
    end
  end

  def export 
    @attendances_csv = make_csv(current_employee.attendances)

    respond_to do |format|
      format.html
      format.csv { send_data @attendances_csv, filename: "attendance_list.csv" }
    end
  end

  private

  def attendance_params 
    params.require(:attendance).permit(:attendance_status, :date, :punch_in_time, :punch_out_time)
  end

  def make_csv(attendances)
    attributes = %w[id date punch_in_time punch_out_time attendance_status]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      attendances.each do |attendance|
        csv << attributes.map { |attribute| attendance.send(attribute) }
      end
    end
  end
end
