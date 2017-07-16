class SessionsController < ApplicationController

  def new
    redirect_to root_path if current_user
    @user = User.new
  end
  #
  def create
    if request.env['omniauth.auth']
      user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = user.id
      redirect_to user_dashboard_index_path(user)
    elsif @user && @user.authenticate(params[:session][:password])
      @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:success] = "Logged in as #{@user.first_name}"
      redirect_to user_dashboard_index_path(@user)
    else
      flash[:login_error] = "The email or password you entered is invalid"
        render :new
    end
  end

  # def create
  #   # @user = User.find_by(email: params[:session][:email])
  #   auth = request.env['omniauth.auth']
  #   @user = User.from_omniauth(request.env["omniauth.auth"])
  #   if @user && @user.authenticate(params[:session][:password])
  #     session[:user_id] = @user.id
  #     flash[:success] = "Logged in as #{@user.first_name}"
  #     redirect_to user_dashboard_index_path(@user)
  #   else
  #     flash[:login_error] = "The email or password you entered is invalid"
  #     render :new
  #   end
  # end

  def destroy
    session.clear
    redirect_to root_path
  end

end
