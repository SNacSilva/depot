class SessionsController < ApplicationController
  def new
  end

  def create

   user = User .find_by(name: params[:name])
   if user and user.authenticate(params[:password])
     session[:user_id] = user.id
     redirect_to admin_url
     return
   end
    redirect_to login_url, alert: "Senha inválida"
   end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, notice: "Logged out."
  end
end
