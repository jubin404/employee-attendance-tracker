class Employee::BaseController < ApplicationController
  before_action :authenticate_user

  private

  def authenticate_user
    unless current_employee
      redirect_to new_employee_session_path
    end
  end
end
