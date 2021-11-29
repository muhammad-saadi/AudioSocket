class ApplicationController < ActionController::Base
  #before_action :configure_sign_up_params , if: :devise_controller?
  before_action :configure_permitted_parameters , if: :devise_controller?


  def after_sign_in_path_for(resource_or_scope)
    if @user&.role == 'manager'
        audition_listing_portal_path
    elsif @user&.role == 'artist'
      if @user.artist_profile
        artist_profile_path(@user)
      else
        new_artist_profile_path
      end
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  # def configure_sign_up_params
  #    devise_parameter_sanitizer.permit(:sign_up, keys:[:role])
  # end

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:invite, keys: [:email])
  # end
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys:[:role]
    devise_parameter_sanitizer.permit :accept_invitation, keys: [:email]
end
end
