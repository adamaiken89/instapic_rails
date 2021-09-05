class SecuredController < ApplicationController
  before_action :authorize_request

  private
    def authorize_request
      header = request.headers["Authorization"]
      header = header.split("Bearer ").last if header
      begin
        @decoded = JsonWebToken.decode(header)
        @current_user = User.find(@decoded[:user_id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: [auth: e.message] }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: [auth: e.message] }, status: :unauthorized
      end
    end
end
