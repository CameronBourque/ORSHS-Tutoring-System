# frozen_string_literal: true

# Record of Users registered to the system
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_and_belongs_to_many :tutoring_sessions
  has_and_belongs_to_many :courses
  has_and_belongs_to_many :roles

  validate :email_domain
  def email_domain
    domain = email.split('@').last
    if email.present? && ((domain != 'tamu.edu') && (domain != 'spartan-tutoring.com'))
      errors.add(:email,
                 'Invalid Domain. Please use your TAMU or Spartan email')
    end
  end
end
