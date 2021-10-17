class ApplicationController < ActionController::Base
  #before_action :authenticate_customer!,except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # def after_sign_in_path_for(resource)
  #   customer_path(current_customer.id)
  # end  
  
  # def after_sign_in_path_for(resource)
  #   admins_customers_path
  # end  
  # 
  # def after_sign_in_path_for(resource)
  #   case resource
  #     when Admins
  #       admins_customers_path          #pathは設定したい遷移先へのpathを指定してください
  #     when Customer
  #       customers_path(current_customer.id) 
  #   end
  # end
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end
end