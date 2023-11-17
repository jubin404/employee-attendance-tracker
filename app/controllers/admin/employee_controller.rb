class Admin::EmployeeController < Admin::BaseController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  
  def index
    @employee = Employee.new
    @employees = Employee.all
    @employees = filter_by_name(@employees).page(params[:page]).order(created_at: :desc)
  end

  def edit
  end

  def update
    if @employee.update(employee_params) && employee_address.update(address_params)
      flash[:notice] = "Employee was updated successfully."
      redirect_to admin_employee_path(@employee)
    else
      flash[:notice] = @employee.errors.full_messages
      render 'edit'
    end
  end

  def new
    @employee = Employee.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create    
    @employee = Employee.new(employee_params)
    @employee[:company_id] = 'TM-TEMP'
    if @employee.save
      update_employee_company_id
      save_employee_address
      flash[:notice] = "Employee was added successfully."
      redirect_to admin_employee_index_path
    else
      flash[:notice] = @employee.errors.full_messages
      render 'new'
    end
  end
  
  def show
    @employee_attendances = @employee.attendances.page(params[:page]).order(created_at: :desc)
  end

  def destroy
    @employee.destroy
    redirect_to admin_employee_index_path
  end
  
  def export 
    @employees = Employee.all
    @employees = filter_by_name(@employees)
    @employees_csv = make_csv(@employees)

    respond_to do |format|
      format.html
      format.csv { send_data @employees_csv, filename: "employee_list.csv" }
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :phone_number, :password, :gender_id)
  end

  def address_params
    params.require(:employee).require(:address).permit(:line_one, :line_two, :city, :pin, :country)
  end

  def save_employee_address
    @address = Address.new(address_params)
    @address[:employee_id] = @employee[:id]
    @address[:status] = 'active'
    @address.save
  end

  def update_employee_company_id
    @employee.update(company_id: "TM0#{@employee[:id]}")
  end

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_address
    @employee.addresses.find_by(status: 'active')
  end

  def filter_by_name(employees)
    return employees unless params[:employee_name].present?
    
    employees.find_by_name(params[:employee_name])
  end

  def make_csv(employees)
    attributes = %w[id company_id email first_name last_name phone_number]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      employees.each do |employee|
        csv << attributes.map { |attribute| employee.send(attribute) }
      end
    end
  end
end
