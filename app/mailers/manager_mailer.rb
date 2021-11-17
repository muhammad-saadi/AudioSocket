class ManagerMailer < ApplicationMailer
  def accept_mail
    @audition = params[:audition]
    mail(to: @audition.email, subject: 'Audition Result')
end
end
