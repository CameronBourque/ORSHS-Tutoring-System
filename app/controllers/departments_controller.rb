# frozen_string_literal: true

class DepartmentsController < ApplicationController
  def new
    @department = Department.new
  end

  def index
    @departments = Department.all
  end

  def show
    @department = Department.find(params[:id])
    @courses = @department.courses
  end

  def edit
    @department = Department.find(params[:id])
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      flash[:success] = 'department saved!'
      redirect_to new_course_path
    else
      flash[:alert] = @department.errors
      redirect_to new_department_path
    end
  end

  def delete; end

  def destroy; end

  def department_params
    params.require(:department).permit(:department_name, course_ids: [])
  end
end
