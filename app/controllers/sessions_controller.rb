class SessionsController < ApplicationController

  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase) #Busca el usuario que tenga el email pasado por parametro (params[:session][:email])
  	if user && user.authenticate(params[:session][:password]) #Ambas deben ser true -> si user es true quiere decir que encontro el usuario en la sentencia anterior
    	sign_in user
    	redirect_to user
	else
      flash.now[:error] = 'Invalid email/password combination' #El mensaje se muestra y desaparece luego de que se haga otra solicitud
      render 'new'
  end

  end

  def destroy
  	sign_out 
  	redirect_to root_url
  end

end
