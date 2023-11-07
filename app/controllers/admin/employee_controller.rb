class Admin::EmployeeController < ApplicationController
  
  def index
  end

  def edit
  end

  def new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end
end
