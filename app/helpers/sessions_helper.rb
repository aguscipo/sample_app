module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token #Crear token
    cookies.permanent[:remember_token] = remember_token # Ubicar token en las cookies del browser
    user.update_attribute(:remember_token, User.digest(remember_token)) #guardar token (hasheado) en la base de datos
    self.current_user = user #No es necesario si hay redirect despues del sign in
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.digest(cookies[:remember_token]) #Recordar que el token esta hasheado por eso es necesario este comando antes de recuperar el token
    @current_user ||= User.find_by(remember_token: remember_token) #Recupero al usuario de la BD a traves del remember token
  end

  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil #Si hay redirect despues no es necesario
  end

end
