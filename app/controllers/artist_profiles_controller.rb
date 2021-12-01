class ArtistProfilesController < ApplicationController
  before_action :get_artist, only: [:upgrade, :pay, :profile, :edit, :update, :show]

  def new
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
    @client_token = Payment.generate_token
  end

  def pay
    payment = Payment.payment(params[:nonce])
    if payment.success? || payment.transaction
      logger.info("transaction done")
      @artist.pro = true
      @artist.save
      redirect_to artist_profile_path
    else
      flash[:error] = "Error occurred during payment"
      redirect_to edit_artist_profile_path(current_user.artist_profile)
    end
  end

  def profile
  end

  def edit
  end

  def update
    @artist.update(artist_profile_params)
    redirect_to artist_profile_path(@artist)
  end

  def show
  end

  private

  def get_artist
    @artist = current_user.artist_profile
  end

  def artist_profile_params
    params.require(:artist_profile).permit(:artist_name, :email, :avatar, :country, :website_link, :bio, social_link: [])
  end
end
