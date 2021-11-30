class Manager::AuditionsController < ApplicationController
  #before_action :authenticate_user!
  before_action :get_audition, only: [:show, :accept_mail, :set_manager, :send_mail]
  def index
    if params[:query].present?
      @auditions = Audition.search_by_name(params[:query])
    else
      @auditions = Audition.all
    end
    respond_to do |format|
      format.html {render action: 'index'}
      format.js
      format.csv {send_data @auditions.to_csv, filename: "auditions-#{Date.today}.csv"}
    end
  end

  def set_manager
    @auditions = Audition.all
    @audition.assigned = params[:assigned]
    @audition.save!
    render 'index'
  end

  def show
    respond_to do |format|
      format.js
    end
  end

  def accept_mail
    @audition.status = params[:status]
    if params[:status] == 'accepted'
      @audition.status_mail = Audition::ACCEPT
    else
      @audition.status_mail = Audition::REJECT
    end
    @audition.save!
    respond_to do |format|
      format.js
    end
  end

  def send_mail
    @audition.status_mail = params[:audition][:status_mail]
    @audition.save!
    if @audition.status == "accepted"
      User.invite!(:email => @audition[:email], email_content: @audition[:status_mail], role: "artist")
    else
      # use in  model
      ManagerMailer.with(audition: @audition).accept_mail.deliver_now
    end
  end

  private

  def get_audition
    @audition = Audition.find(params[:id])
  end
end
