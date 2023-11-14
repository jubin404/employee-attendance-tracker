# app/controllers/admin/base_controller.rb
class Admin::BaseController < ApplicationController
  before_action :authenticate_admin

  private

  def authenticate_admin
    unless current_admin
      flash[:alert] = 'You are not authorized to access this page. Please log in as an admin.'
      redirect_to new_admin_session_path
    end
  end
end
