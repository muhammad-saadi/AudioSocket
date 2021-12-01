class Manager::AuditionsController < ApplicationController
  before_action :get_audition, only: [:show, :accept_mail, :set_manager, :send_mail]

  def index
    if params[:query].present?
      @auditions = Audition.search_by_name(params[:query])
    else
      @auditions = Audition.all
    end
    respond_to do |format|
      format.html { render action: 'index' }
      format.js
      format.csv { send_data @auditions.to_csv, filename: "auditions-#{Date.today}.csv" }
    end
  end

  def set_manager
    @auditions = Audition.all
    @audition.assigned = params[:assigned]
    @audition.save!
    render 'index'
  end

  def show; end

  def accept_mail
    #move to controller
    @audition.status = params[:status]
    if params[:status] == 'accepted'
      @audition.status_mail = Audition::ACCEPT
    else
      @audition.status_mail = Audition::REJECT
    end
    @audition.save!
  end

  def send_mail
    # move whole to model
    if @audition.update(mail_content_params)
      # @audition.send_response_mail
      User.invite!(email: @audition[:email], email_content: @audition[:status_mail], role: "artist")
    else
      # use in  model
      ManagerMailer.with(audition: @audition).accept_mail.deliver_now
    end
  end

  private

  def get_audition
    @audition = Audition.find(params[:id])
  end

  def mail_content_params
    params.require(:audition).permit(:status_mail)
  end
end
