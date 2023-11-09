class Admin::EmployeeController < Admin::BaseController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  
  def index
    @employees = Employee.all
  end

  def edit
  end

  def update
    if @employee.update(employee_params) && employee_address.update(address_params)
      flash[:notice] = "Employee was updated successfully."
      redirect_to admin_employee_path(@employee)
    else
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
      @employee.update(company_id: employee_company_id)
      save_employee_address
      flash[:notice] = "Employee was added successfully."
      redirect_to admin_employee_index_path
    else
      flash[:notice] = "Something went wrong"
      render 'new'
    end
  end
  
  def show
  end

  def destroy
    @employee.destroy
    redirect_to admin_employee_index_path
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

  def employee_company_id
    "TM0#{@employee[:id]}"
  end

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_address
    @employee.addresses.find_by(status: 'active')
  end
end
