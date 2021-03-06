# frozen_string_literal: true

module UserControllerHelper
  def pending_mail_with(tutor, student)
    TutoringSessionMailer.with(to: tutor, student: student)
  end

  def create_or_update_link_for(user, tutoring_session, session_course, student_notes)
    link = TutoringSessionUser.find_or_create_by(tutoring_session: tutoring_session, user: user)
    link.link_status = 'pending'
    tutor_sess = TutoringSession.find(link.tutoring_session_id)
    tutor_sess.session_status = 'pending'
    tutor_sess.save!
    link.session_course = session_course
    link.student_notes = student_notes if student_notes.nil? == false
    link.save if session_course.nil? == false
    Notification.notify_student_application_for(tutoring_session.tutor, user, link)
  end

  def bounce
    redirect_to "/users/#{current_user.id}"
  end

  def bounce_unless_ad_or_match(user)
    bounce and return unless user == current_user || current_user.admin?
  end

  def get_status(session)
    sess = TutoringSessionUser.where('tutoring_session_id = ?', session.id).first
    return nil if sess.nil?

    sess.link_status
  end
end
