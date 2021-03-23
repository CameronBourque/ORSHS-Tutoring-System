# frozen_string_literal: true

require 'rails_helper'
RSpec.describe UsersController, type: :feature do
  let(:frozen_time) { '25 May 02:00:00 +0000'.to_datetime }
  let(:user) {User.create(first_name: 'Admin', last_name: 'User', password: 'T3st!!a', email: 'admin@tamu.edu')}
  let(:tutor) {User.create(first_name: 'Tutor', last_name: 'User', password: 'T3st!!a', email: 'tutor@tamu.edu')}
  after { Timecop.return }

  before do
    Timecop.freeze(frozen_time)

    visit('/users/sign_in/')
    fill_in 'user_email', with: 'admin@tamu.edu'
    fill_in 'user_password', with: 'T3st!!a'

    find(:link_or_button, 'Log in').click
  end

  
  
end