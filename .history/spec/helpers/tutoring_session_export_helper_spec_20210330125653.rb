# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TutoringSessionExportHelper, type: :helper do
  let(:tutor) do
    User.create(
      first_name: 'Tutor',
      last_name: 'User',
      password: 'T3st!!a',
      email: 'tutor@tamu.edu'
    )
  end
  let(:tutoring_sessions) do
    [TutoringSession.create(scheduled_datetime: '28 May 2021 08:00:00 +0000'.to_datetime,
                            complete_datetime: '28 May 2021 09:00:00 +0000'.to_datetime,
                            session_status: 'complete',
                            tutor_id: tutor.id),
     TutoringSession.create(scheduled_datetime: '26 May 2021 08:00:00 +0000'.to_datetime,
                            complete_datetime: '26 May 2021 09:00:00 +0000'.to_datetime,
                            session_status: 'complete',
                            tutor_id: tutor.id),
     TutoringSession.create(scheduled_datetime: '27 May 2021 08:00:00 +0000'.to_datetime,
                            complete_datetime: '27 May 2021 09:00:00 +0000'.to_datetime,
                            session_status: 'complete',
                            tutor_id: tutor.id)]
  end
  let(:start_date) {'19 January 2021 08:00:00 +0000'.to_datetime}
  let(:end_date) {'30 May 2021 08:00:00 +0000'.to_datetime}
  let(:csv_string) {nil}
  before do
    # Instead of output to file, output to string
    allow(CSV).to receive(:<<) do |arg1|
      csv_string = [arg1[0], arg1[1]].to_csv
    end
  end
  it "adds all tutoring hours" do
    tutor.tutoring_sessions << tutoring_sessions
    TutoringSessionExportHelper.create_csv(start_date, end_date, 'spec/helpers/tutoring_hours_spec.csv')
    expect(CSV.parse_line(csv_string)).to eq(["Tutor User", "3"])

  end
end
