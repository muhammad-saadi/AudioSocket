class ManagersController < ApplicationController
  def audition_listing_portal
    if params[:query].present?
      @auditions = Audition.search_by_name(params[:query])
    else
      @auditions = Audition.all
    end
    respond_to do |format|
      format.html {render action: 'audition_listing_portal'}
      format.js
      format.csv {send_data @auditions.to_csv, filename: "auditions-#{Date.today}.csv"}
    end
  end

  def set_manager
    @auditions = Audition.all
    @audition = Audition.find(params[:id])
    @audition.assigned = params[:assigned]
    @audition.save!
    render 'audition_listing_portal'
  end

  def show
    @audition =Audition.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def set_status
    @auditions = Audition.all
    @audition = Audition.find(params[:id])
    @audition.status = params[:status]
    @audition.save!
    render 'audition_listing_portal'
  end

  def accept_mail
    @audition = Audition.find(params[:id])
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
    @audition = Audition.find(params[:id])
    @audition.status_mail = params[:audition][:status_mail]
    @audition.save!
    if(@audition.status == "accepted")
      User.invite!(:email => @audition[:email], email_content: @audition[:status_mail], role: "artist")
    else
      ManagerMailer.with(audition: @audition).accept_mail.deliver_now
    end
  end
end
