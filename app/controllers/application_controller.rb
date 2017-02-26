class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # määritellään, että metodi current_user tulee käyttöön myös näkymissä
  helper_method :current_user

  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end
=begin
  def current_admin
    return nil if session[:user_id].nil?
    user = User.find(session[:user_id])
    return nil if user.admin.nil? || user.admin == false
      return user
  end
=end
  def ensure_that_signed_in
    redirect_to signin_path, notice:'you should be signed in' if current_user.nil?
  end

  def ensure_that_admin
    redirect_to signin_path, notice:'you should be signed in as admin' if current_user.nil? || current_user.admin.nil? || current_user.admin == false
  end


end
