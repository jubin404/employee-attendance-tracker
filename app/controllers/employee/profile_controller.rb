class Employee::ProfileController < Employee::BaseController
  
  def index
    @attendances = current_employee.attendances.page(params[:page]).order(created_at: :desc)
  end

  def edit
  end

  def update
    if current_employee.update(employee_params) && employee_address.update(address_params)
      flash[:notice] = "Profile was updated successfully."
      redirect_to profile_path
    else
      render 'edit'
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :phone_number, :password, :gender_id)
  end

  def address_params
    params.require(:employee).require(:address).permit(:line_one, :line_two, :city, :pin, :country)
  end

  def employee_address
    current_employee.addresses.find_by(status: 'active')
  end
end
