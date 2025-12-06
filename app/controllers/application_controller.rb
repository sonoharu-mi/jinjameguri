class ApplicationController < ActionController::Base
 
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    posts_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def block_guest_user
    if current_user&.guest_user?
      redirect_to root_path, alert: "ゲストユーザーはこの機能を利用できません。"
    end
  end

  private
  def admin_controller?
    self.class.module_parent_name == 'Admin'
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end
