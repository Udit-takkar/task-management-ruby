class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to tasks_path, notice: "Logged in successfully"
    else 
      flash_now[:alert] = "Invalid email or password"
      render :new, status: :unprocessed_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out!"
  end
end
