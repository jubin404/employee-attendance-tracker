class Admin::BaseController < ApplicationController
  before_action :authenticate_admin

  private

  def authenticate_admin
    unless current_admin
      redirect_to new_admin_session_path
    end
  end
end
