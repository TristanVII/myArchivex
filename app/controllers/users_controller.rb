class UsersController < ApplicationController
  # Skip authentication check for the new and create actions,
  # as users need to be able to sign up without being logged in.
  allow_unauthenticated_access only: [ :new, :create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # Log the user in immediately after successful registration.
      # Assuming the Authentication concern provides a method like start_new_session_for.
      # We need to check the exact method name in app/controllers/concerns/authentication.rb
      start_new_session_for @user
      redirect_to root_path, notice: "Successfully created account!" # Redirect to root or dashboard after sign up
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end
