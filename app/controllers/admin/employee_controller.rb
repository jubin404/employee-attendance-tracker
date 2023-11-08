class Admin::EmployeeController < Admin::BaseController
  
  def index
    @employees = Employee.all
  end

  def edit
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
  
  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :phone_number, :password, :gender_id)
  end

  def address_params
    params.require(:employee).permit(:line_one, :line_two, :city, :pin, :country)
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
end
