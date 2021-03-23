# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Course, type: :model do
  let(:department) {Department.new(department_name: 'MATH')}

  subject(:course) {described_class.new(id: 0, course_name: '301', department_id: department.id)}

  before do
    department.save
  end

  it 'is valid with a department and name' do
    expect(course).to be_valid
  end

  it 'is not valid without a name' do
    course.course_name = nil
    expect(course).not_to be_valid
  end

  it 'is not valid without a department' do
    course.course_name = '301'
    course.department_id = nil
    expect(course).not_to be_valid
  end

  after do
    department.delete
  end
end
