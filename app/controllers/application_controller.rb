class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope&.role == 'manager'
      manager_auditions_path
    elsif resource_or_scope&.role == 'artist'
      if resource_or_scope.artist_profile
        artist_profile_path
      else
        new_artist_profile_path
      end
    else
      albums_path
    end
  end

  def after_sign_out_path_for(_)
    new_user_session_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:role]
    devise_parameter_sanitizer.permit :accept_invitation, keys: [:email]
  end
end
