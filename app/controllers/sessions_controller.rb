class SessionsController < ApplicationController
  # POST /sessions
  def create
    @user = User.find_by(name: user_params[:name])
    if @user&.authenticate(user_params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 1.hour.to_i
      render json: {
              token: token,
              exp: time.strftime("%m-%d-%Y %H:%M"),
              name: @user.name
            }, status: :created
    else
      render json: { errors: [password: ["Password is not correct"]] }, status: :unauthorized
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :password)
    end
end
