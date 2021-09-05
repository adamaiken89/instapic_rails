class ErrorsController < ActionController::API
  def not_found
    render json: { errors: [ route: "Routes not found"] }, status: :not_found
  end
end
