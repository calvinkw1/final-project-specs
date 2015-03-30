class UsersController < ApplicationController
  before_action :confirm_logged_in, only: [:home]
  before_action :prevent_login_signup, only: [:signup, :login]
  def main
  end

  def signup
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver_later
      session[:user_id] = @user.email
      flash[:success] = "User was successfully created."
      redirect_to root_path
    else
      render :signup
    end
  end

  def attempt_login

    if params[:email].present? && params[:password].present?
      found_user = User.find_by_email params[:email]

      session[:user_id] = found_user.id

      if found_user
        authorized_user = found_user.confirm params[:password]
      end
    end

    if !found_user
      flash.now[:alert] = "Invalid email"
      render :login

    elsif !authorized_user
      flash.now[:alert] = "Invalid password"
      render :login

    else
      session[:user_id] = authorized_user.email
      redirect_to root_path, flash: {success: "You are now logged in."}
    end
  end


  def login
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to login_path
  end

  private 
    def user_params
      params.permit(:email, :first_name, :last_name, :password, :password_digest)
    end

    def confirm_logged_in
      unless session[:user_id]
        redirect_to login_path, alert: "Please log in"
      end
    end

    def prevent_login_signup
        if session[:user_id]
          redirect_to root_path
        end
    end

end
