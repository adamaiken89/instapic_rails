class UsersController < ApplicationController
  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: { data: { user: @user.slice(:id, :name, :created_at, :updated_at) } }, status: :created
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :password)
    end
end
