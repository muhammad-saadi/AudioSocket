class ArtistProfilesController < ApplicationController
  def  new
    @artist = ArtistProfile.new
    @artist.email = current_user.email
    @audition = Audition.find_by_email(@artist.email)
    @artist.artist_name = @audition.artist_name
  end

  def create
    current_user.artist_profile = ArtistProfile.new(artist_profile_params)
    redirect_to artist_profile_path(current_user.artist_profile)
  end

  def upgrade
    @artist = ArtistProfile.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def transaction
    @artist = current_user.artist_profile
    payment = Payment.payment(params[:nonce])
      debugger
    if payment.success? || payment.transaction
      redirect_to artist_profile_path(current_user.artist_profile)
    else
      flash[:error] = "Error occured during payment"
      redirect_to edit_artist_profile_path(current_user.artist_profile)
    end
  end

  def profile
    @artist = current_user.artist_profile
  end

  def edit
    @artist = ArtistProfile.find(params[:id])
    @client_token = Payment.generate_token
  end

  def update
    @artist_profile = ArtistProfile.find(params[:id])
    @artist_profile.update(artist_profile_params)
    redirect_to artist_profile_path(@artist_profile)

  end

  def show
    @artist = current_user.artist_profile
  end

  private

  def artist_profile_params
    params.require(:artist_profile).permit(:artist_name, :email, :avatar, :country, :website_link, :bio, social_link:[])
  end
end
