# frozen_string_literal: true

class TutoringSessionUserController < ApplicationController
  before_action :authenticate_user!

  def show
    @pending_links = TutoringSessionUser.joins(:tutoring_session)
                                        .where(tutoring_session: { tutor_id: current_user.id })
                                        .where(link_status: 'pending')
  end

  def confirm_pending_link
    link = TutoringSessionUser.find(params[:id])
    unless (link.tutoring_session.tutor == current_user) || current_user.is_admin?
      redirect_to action: 'show'
    end
    link.link_status = 'confirmed'
    tutor_sess_update(link, 'confirmed')

    mail_with(link, 'confirmed').link_action_email.deliver_now

    redirect_to action: 'show'
  end

  def deny_pending_link
    link = TutoringSessionUser.find(params[:id])
    unless (link.tutoring_session.tutor == current_user) || current_user.is_admin?
      redirect_to action: 'show'
    end

    link.link_status = 'denied'
    tutor_sess_update(link, 'denied')

    mail_with(link, 'denied').link_action_email.deliver_now

    redirect_to action: 'show'
  end

  def tutor_sess_update(link, status)
    tutor_sess = TutoringSession.find(link.tutoring_session_id)
    tutor_sess.session_status = status
    tutor_sess.save!
    link.save
  end

  private

  def mail_with(link, link_action)
    TutoringSessionMailer.with(
      to: link.user,
      tutor: current_user,
      tsession: link.tutoring_session,
      link_action: link_action,
      message: params['message-text']
    )
  end
end
