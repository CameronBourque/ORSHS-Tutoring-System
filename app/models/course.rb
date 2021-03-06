# frozen_string_literal: true

# Courses that are registered into the database
class Course < ApplicationRecord
  # has_and_belongs_to_many :users
  has_many :course_users, dependent: :delete_all
  has_many :users, through: :course_users
  belongs_to :department
  # has_and_belongs_to_many :tutoring_sessions
  has_many :course_tutoring_sessions, dependent: :delete_all
  has_many :tutoring_sessions, through: :course_tutoring_sessions
  validates :course_name, presence: true
  validates :department_id, presence: true
  validates :course_name, uniqueness: { scope:
    :department_id, message: lambda { |_x, y|
                               "#{y[:value]}
    already edists for this deparment."
                             } }
end
